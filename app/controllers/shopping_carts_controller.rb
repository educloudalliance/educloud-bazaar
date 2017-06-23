class ShoppingCartsController < ApplicationController
  before_action :authenticate_viewer!
  before_action :find_material, only: %i[create destroy]
  before_action :current_session, only: %i[show cancel]

  def create
    current_shopping_cart.add(@material, (rand(20) + 1))
    redirect_to :back, cart_items: current_shopping_cart.cart_items.size, notice: 'Successfully added to the cart'
  end

  def show
    @resources = current_shopping_cart.shopping_cart_items.with_material
  end

  def cancel
    current_shopping_cart.clear
    redirect_to current_session.cancel_url
  end

  def destroy
    current_shopping_cart.remove(@material, 1)
    redirect_to shopping_cart_path, alert: 'Item was removed from cart'
  end
end
