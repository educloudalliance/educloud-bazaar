module SamlHelper
  def current_user
    session[:nameid]
  end

  def auth_user
    if current_user.nil?
      redirect_to saml_index_path
    end
  end
end
