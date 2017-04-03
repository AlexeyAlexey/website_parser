require 'open-uri'

class WebParserUpdateReviewsWorker
  include Sidekiq::Worker

  sidekiq_options :queue => :update_information, :retry => 2

  # The current retry count is yielded. The return value of the block must be 
  # an integer. It is used as the delay, in seconds. 
  #sidekiq_retry_in do |count|
    #10 * (count + 3) # (i.e. 10, 20, 30, 40, 50)
  #end

  def perform(*args)
    # Do something
    product_id, = args

    product = Product.find(product_id)
    reviews_parser(product)

    product.reload.status = 1
    product.save
  end

  def reviews_parser(product)

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
