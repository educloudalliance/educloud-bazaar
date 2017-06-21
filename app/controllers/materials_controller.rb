class MaterialsController < ApplicationController
  before_action :authenticate_viewer!
  before_action :extract_shopping_cart, only: :index
  before_action :cart_items_count

  def index
    @materials = Material.by_viewer(current_session[:city_id], current_session[:school_id]).order(id: :asc)
      .paginate(page: params[:page], per_page: 3)
  end

  def show
    @material = Material.by_viewer(current_session[:city_id], current_session[:school_id]).find(params[:id])
  end

  private

  def cart_items_count
    shopping_cart_id = session[:shopping_cart_id]
    cart = ShoppingCart.find(shopping_cart_id)
    @cart_items = "(#{cart.cart_items.size})"
  end
end
