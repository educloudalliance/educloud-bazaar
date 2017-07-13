class ChangeDefaultNullFieldsInCmsSession < ActiveRecord::Migration[5.0]
  def change
    change_column_null :cms_sessions, :first_name, true
    change_column_null :cms_sessions, :last_name, true
    change_column_null :cms_sessions, :context_id, true
    change_column_null :cms_sessions, :context_title, true
  end
end
