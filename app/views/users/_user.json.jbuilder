json.extract! user, :id, :nombre, :primerApellido, :segundoApellido, :correo, :contrasenna, :foto, :token, :created_at, :updated_at
json.url user_url(user, format: :json)
