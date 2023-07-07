class CreateRawMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_materials do |t|
      t.string :name
      t.string :category
      t.string :supplier
      t.integer :score

      t.timestamps
    end
  end
end
