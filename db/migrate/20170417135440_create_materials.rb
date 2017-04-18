class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.string :name, null: false, limit: 255
      t.text :description, null: false
      t.string :language, null: false
      t.integer :publisher_resource_id, unique: true
      t.text :publisher_data
      t.text :metadata, array: true, default: []
      t.timestamps
    end
  end
end
