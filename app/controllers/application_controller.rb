class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to materials_path, alert: 'Material not found'
  end

  protected

  def current_session
    return @current_session if defined? @current_session

    @current_session ||= CmsSession.find_by(uid: session[:session_id])
  end

  def find_material
    @material = Material.find(params[:id])
  end

  def extract_shopping_cart
    @shopping_cart = ShoppingCart.find(session[:shopping_cart_id])
  end

  def authenticate_viewer!
    if session[:session_id].nil?
      reset_session
      render json: { error: 'Not Authorized' }
    end
  end
end
