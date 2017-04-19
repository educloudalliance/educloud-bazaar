class ChangeImageColumnType < ActiveRecord::Migration[5.0]
  def change
    rename_column :images, :type, :kind
  end
end
