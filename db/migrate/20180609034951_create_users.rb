class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :primerApellido
      t.string :segundoApellido
      t.string :correo
      t.string :contrasenna
      t.string :foto
      t.string :token

      t.timestamps
    end
  end
end
