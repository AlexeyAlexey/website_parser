class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.integer :product_id,   null: false
      t.text    :message,      null: false
      t.string  :hash_message, limit: 64,   default: "", null: false

      t.timestamps null: false
    end
    add_index :product_reviews, :product_id, :name => :product_reviews_product_id
    add_index :product_reviews, :hash_message, :unique => true, :name => :product_reviews_hash_message

  end
end
