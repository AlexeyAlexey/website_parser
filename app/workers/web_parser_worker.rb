require 'open-uri'

class WebParserWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :web_parser, :retry => 2

  # The current retry count is yielded. The return value of the block must be 
  # an integer. It is used as the delay, in seconds. 
  #sidekiq_retry_in do |count|
    #10 * (count + 3) # (i.e. 10, 20, 30, 40, 50)
  #end

  def perform(*args)
    # Do something
    product_id, = args

    product = Product.find(product_id)
    url = product.url

    #https://www.walmart.com/ip/Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789
    #https://www.walmart.com/reviews/product/28806789?limit=20&page=2&sort=relevancy

    page = Nokogiri::HTML(open(url))

    name = page.css("h1.prod-ProductTitle").css("div").text
    price = page.css("span[itemprop=price]").attr("content").value
    name_downcase = url.mb_chars.downcase.to_s.gsub(/[[:space:]]/, '')
    hash_name = Digest::SHA256.hexdigest(name_downcase)
    

    set_product_params = {}
    set_product_params[:name]      = name
    set_product_params[:hash_name] = hash_name
    set_product_params[:price]  = price
    set_product_params[:status] = 1

    unless Product.exists?(hash_name: hash_name)
      product.update(set_product_params)
      reviews_parser(product)
    else
      product.update(status: 2)
    end
  end

  def reviews_parser(product)
    product.reload
    url = product.url
    url_request = URI.parse(url)

    url_params = url_request.path.match(/\/ip\/(\S*)\/(\d*)/)
    product_identificator = url_params[2]


    scheme = url_request.scheme
    host   = url_request.host

    url_request = proc { |page| "#{scheme}://#{host}/reviews/product/#{product_identificator}?limit=20&page=#{page}&sort=relevancy"}

    page = 1
    next_page = true
    while next_page

      page_view = Nokogiri::HTML(open(url_request.call(page)))

      reviews = page_view.css("div.customer-review-text").css("div")
      reviews.each do |el|
        hash_message = Digest::SHA256.hexdigest( el.text.mb_chars.downcase.to_s.gsub(/[[:space:]]/, '') )

        product.product_reviews.new({message: el.text, hash_message: hash_message}).save
      end
   
      page += 1

      next_page = reviews.size != 0
    end

  end
end
