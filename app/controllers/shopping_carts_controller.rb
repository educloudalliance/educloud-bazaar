class ShoppingCartsController < ApplicationController
  before_action :extract_shopping_cart
  before_action :find_material, only: %i[create destroy]

  def create
    @shopping_cart.add(@material, (rand(20) + 1))
    redirect_to :back, cart_items: @shopping_cart.cart_items.size, notice: 'Successfully added to the cart'
  end

  def show
    @resources = @shopping_cart.shopping_cart_items.with_material
  end

  def destroy
    @shopping_cart.remove(@material, 1)
    redirect_to shopping_cart_path, alert: 'Item was removed from cart'
  end
end
