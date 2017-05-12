class AddEnabledToMetadata < ActiveRecord::Migration[5.0]
  def change
    add_column :metadata, :enabled, :boolean, default: true
  end
end
