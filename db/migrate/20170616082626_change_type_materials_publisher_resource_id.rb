class ChangeTypeMaterialsPublisherResourceId < ActiveRecord::Migration[5.0]
  def up
    change_column :materials, :publisher_resource_id, :string
  end

  def down
    change_column :materials, :publisher_resource_id, :integer
  end
end
