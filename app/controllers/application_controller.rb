class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to materials_path, alert: 'Material not found'
  end

  helper_method :current_cart, :user_sign_in?

  protected

  def current_session
    @current_session ||= CmsSession.find_by(id: session[:cms_session_id])
  end

  def find_material
    @material = Material.find(params[:id])
  end

  def current_cart
    @shopping_cart ||= current_session.shopping_cart
  end

  def user_sign_in?
    current_session
  end

  def authenticate_viewer!
    if session[:cms_session_id].nil?
      reset_session
      render json: { error: 'Not Authorized' }
    end
  end
end
