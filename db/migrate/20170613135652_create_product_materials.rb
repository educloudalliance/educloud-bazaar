class CreateProductMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :product_materials do |t|
      t.references :product
      t.references :material

      t.timestamps
    end

    add_index :product_materials, [:product_id, :material_id],  unique: true
  end
end
