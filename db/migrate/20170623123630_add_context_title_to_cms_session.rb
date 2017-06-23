class AddContextTitleToCmsSession < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_sessions, :context_title, :string, null: false
  end
end
