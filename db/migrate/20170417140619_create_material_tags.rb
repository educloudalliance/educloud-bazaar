class CreateMaterialTags < ActiveRecord::Migration[5.0]
  def change
    create_table :material_tags do |t|
      t.references :tag, null: false, index: true
      t.references :material, null: false, index: true
      t.timestamps
    end
  end
end
