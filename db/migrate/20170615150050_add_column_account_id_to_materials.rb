class AddColumnAccountIdToMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :account_id, :integer, null: false
  end
end
