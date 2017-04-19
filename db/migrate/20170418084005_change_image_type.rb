class ChangeImageType < ActiveRecord::Migration[5.0]
  def change
    change_column :images, :type, 'integer USING CAST(type AS integer)'
  end
end
