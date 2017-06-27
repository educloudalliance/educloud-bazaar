class SessionsController < ApplicationController
  def show
    cms_session = CmsSession.find_by(uid: params[:id])
    if cms_session
      session[:cms_session_id] = cms_session.id
      ShoppingCart.create(cms_session_id: cms_session.id)
      redirect_to materials_path
    else
      redirect_to root_path
    end
  end
end
