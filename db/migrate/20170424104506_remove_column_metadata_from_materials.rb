class RemoveColumnMetadataFromMaterials < ActiveRecord::Migration[5.0]
  def change
    remove_column :materials, :metadata, :text, array: true, default: []
  end
end
