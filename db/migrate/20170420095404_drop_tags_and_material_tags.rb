class DropTagsAndMaterialTags < ActiveRecord::Migration[5.0]
  def up
    drop_table :material_tags
    drop_table :tags
  end

  def down
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end
    create_table :material_tags do |t|
      t.references :tag, null: false, index: true
      t.references :material, null: false, index: true
      t.timestamps
    end
  end
end
