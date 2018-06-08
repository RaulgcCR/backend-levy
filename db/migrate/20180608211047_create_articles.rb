class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :nombre
      t.float :precio
      t.text :descripcion
      t.integer :proveedor
      t.string :image
      t.integer :modo

      t.timestamps
    end
  end
end
