class AddSessionIdToTheShoppingCart < ActiveRecord::Migration[5.0]
  def change
    add_reference :shopping_carts, :cms_sessions, index: true
  end
end
