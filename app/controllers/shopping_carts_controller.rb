class ShoppingCartsController < ApplicationController
  before_action :authenticate_viewer!
  before_action :find_material, only: %i[create destroy]
  before_action :current_session, only: %i[show cancel]

  def create
    current_cart.add(@material, 0) unless current_cart.cart_items.include? @material
    redirect_to :back, notice: 'Successfully added to the cart'
  end

  def show
    @resources = current_cart.shopping_cart_items.with_material
  end

  def cancel
    current_cart.clear
    redirect_to current_session.cancel_url
  end

  def destroy
    current_cart.remove(@material, 1)
    redirect_to shopping_cart_path, alert: 'Item was removed from cart'
  end
end
