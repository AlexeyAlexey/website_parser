class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, default: ""
      t.decimal :price, precision: 15, scale: 3
      t.string :hash_name, limit: 64, default: "", :null => false
      t.string :url
      t.string :hash_url, limit: 64, default: "", :null => false
      t.integer :status, limit: 1, default: 0

      t.timestamps null: false
    end
    add_index :products, :hash_name, :name => :products_hash_name
    add_index :products, :hash_url,  :unique => true, :name => :products_hash_url
    add_index :products, :status, :name => :products_status

  end
end
