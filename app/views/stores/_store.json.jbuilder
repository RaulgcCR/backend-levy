json.extract! store, :id, :nombre, :latitud, :longitud, :direccion, :descripcion, :imagen, :created_at, :updated_at
json.url store_url(store, format: :json)
