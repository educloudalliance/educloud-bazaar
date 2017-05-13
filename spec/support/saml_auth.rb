module SamlAuth
  def current_user
    session[:nameid] = 'some@email.com'
  end

  def auth_user
    if current_user.nil?
      redirect_to saml_index_path
    else
      cart = FactoryGirl.create(:shopping_cart)
      session[:shopping_cart_id] = cart.id
    end
  end

  def logout_request_document
    xml = File.read(Rails.root.join('spec', 'fixtures', 'slo_request.xml'))
    deflated = Zlib::Deflate.deflate(xml, 9)[2..-5]
    logout_request_document = Base64.encode64(deflated)
    logout_request_document
  end

  def ruby_saml_key_text
    read_certificate('ruby-saml.key')
  end

  def ruby_saml_cert_text
    read_certificate('ruby-saml.crt')
  end

  def read_certificate(certificate)
    File.read(Rails.root.join('spec', 'fixtures', certificate))
  end
end
