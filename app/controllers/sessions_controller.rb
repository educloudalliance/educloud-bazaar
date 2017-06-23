class SessionsController < ApplicationController
  def show
    cms_session = CmsSession.find_by(uid: params[:session_id])
    if cms_session
      session[:cms_session_id] = params[:session_id]
      shopping_cart = ShoppingCart.create(cms_sessions_id: cms_session.id)
      session[:shopping_cart_id] = shopping_cart.id
      redirect_to materials_path
    else
      reset_session
      render json: { error: 'Not Authorized' }
    end
  end
end
