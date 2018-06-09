class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.integer :calificado
      t.integer :calificador
      t.integer :calificacion

      t.timestamps
    end
  end
end
