class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :articulo
      t.integer :persona
      t.text :comentario

      t.timestamps
    end
  end
end
