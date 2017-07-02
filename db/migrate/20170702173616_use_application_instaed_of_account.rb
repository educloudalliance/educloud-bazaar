class UseApplicationInstaedOfAccount < ActiveRecord::Migration[5.0]
  def change
    rename_column :materials, :account_id, :application_id
    rename_column :cms_tokens, :account_id, :application_id
  end
end
