class RenameCmsSessionsIdInShoppingCarts < ActiveRecord::Migration[5.0]
  def change
    rename_column :shopping_carts, :cms_sessions_id, :cms_session_id
  end
end
