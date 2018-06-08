json.extract! article, :id, :nombre, :precio, :descripcion, :proveedor, :image, :modo, :created_at, :updated_at
json.url article_url(article, format: :json)
