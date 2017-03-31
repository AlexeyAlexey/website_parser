class Product < ActiveRecord::Base

  has_many :product_reviews, dependent: :destroy

  validates :url, presence: true
  validates :url, :format => URI::regexp(%w(http https))
  validates_uniqueness_of :hash_url, message: 'URL has already been taken'


  def status_name
    case self.status
    when 0
      I18n.t(:request_is_being_processed, scope: [:status])
    when 1
      I18n.t(:request_is_processed, scope: [:status])
    when 2
      I18n.t(:similar_name_has_already_been_processed, scope: [:status])
    when 3
      I18n.t(:reviews_are_being_updated, scope: [:status])
    else	
      self.status
    end
  end
end
