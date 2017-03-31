json.extract! product, :id, :name, :hash_name, :url, :hash_url, :status, :created_at, :updated_at
json.url product_url(product, format: :json)
