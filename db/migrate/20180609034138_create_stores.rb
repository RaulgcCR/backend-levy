class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :nombre
      t.string :latitud
      t.string :longitud
      t.text :direccion
      t.text :descripcion
      t.string :imagen

      t.timestamps
    end
  end
end
