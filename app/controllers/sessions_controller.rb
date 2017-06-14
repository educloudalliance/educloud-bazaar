class SessionsController < ApplicationController
  def show
    current_session = CmsSession.find_by(uid: params[:session_id])
    if current_session
      session[:session_id] = params[:session_id]
      shopping_cart = ShoppingCart.create(cms_sessions_id: current_session.id)
      session[:shopping_cart_id] = shopping_cart.id
      redirect_to materials_path
    else
      reset_session
      render json: { error: 'Not Authorized' }
    end
  end
end
