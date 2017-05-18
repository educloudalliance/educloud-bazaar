class ShoppingCartItem < ApplicationRecord
  acts_as_shopping_cart_item

  belongs_to :material, foreign_key: 'item_id', class_name: 'Material'

  scope :with_material, (-> { joins(:material) })
end
