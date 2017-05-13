class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include SamlHelper

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to materials_path, alert: 'Material not found'
  end

  def find_material
    @material = Material.find(params[:id])
  end

  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end
end
