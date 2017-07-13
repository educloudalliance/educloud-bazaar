class ChangeFiledRoleInCmsSession < ActiveRecord::Migration[5.0]
  def up
    change_column :cms_sessions, :role, :string
  end

  def down
    change_column :cms_sessions, :role, 'integer USING CAST(role AS integer)', null: false
  end
end
