class CreateMaterialsMetadata < ActiveRecord::Migration[5.0]
  def change
    create_table :materials_metadata do |t|
      t.belongs_to :metadata, index: true
      t.belongs_to :material, index: true
      t.timestamps
    end
  end
end
