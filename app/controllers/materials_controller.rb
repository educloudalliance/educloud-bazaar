class MaterialsController < ApplicationController
  before_action :auth_user
  before_action :cart_items_count

  def index
    @materials = Material.paginate(page: params[:page], per_page: 3)
  end

  def show
    @material = Material.find(params[:id])
  end

  private

  def cart_items_count
    shopping_cart_id = session[:shopping_cart_id]
    cart = ShoppingCart.find(shopping_cart_id)
    @cart_items = "(#{cart.cart_items.size})"
  end
end
