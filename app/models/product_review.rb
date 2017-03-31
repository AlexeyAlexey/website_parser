class ProductReview < ActiveRecord::Base

  belongs_to :product

  validates_uniqueness_of :hash_message, message: 'message has already been taken'
end
