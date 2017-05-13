require 'rails_helper'

RSpec.describe SamlController, type: :controller do
  describe 'SAML authrequest' do
    before do
      get :sso
      settings.idp_sso_target_url = 'http://example.com'
    end
    let(:settings) { OneLogin::RubySaml::Settings.new }

    it 'create the SAMLRequest URL parameter with NameID Format' do
      settings.name_identifier_format = 'urn:oasis:names:tc:SAML:2.0:nameid-format:emailAddress'
      auth_url = OneLogin::RubySaml::Authrequest.new.create(settings)
      payload = CGI.unescape(auth_url.split('=').last)
      decoded = Base64.decode64(payload)
      zstream = Zlib::Inflate.new(-Zlib::MAX_WBITS)
      inflated = zstream.inflate(decoded)
      zstream.finish
      zstream.close

      expect(auth_url).to include('http://example.com?SAMLRequest=')
      expect(inflated).to match(/<samlp:NameIDPolicy[^<]* AllowCreate='true'/)
      expect(inflated)
        .to match(/<samlp:NameIDPolicy[^<]* Format='urn:oasis:names:tc:SAML:2.0:nameid-format:emailAddress'/)
    end
  end

  describe 'SAML authresponse' do
    let(:test_response) { File.read(Rails.root.join('spec', 'fixtures', 'signed_unqual_nameid_in_atts.xml')) }
    before do
      post :acs, params: {SAMLResponse: test_response}
      settings.idp_sso_target_url = 'http://example.com'
    end

    let(:settings) { OneLogin::RubySaml::Settings.new }
    let(:response) { OneLogin::RubySaml::Response.new(test_response, settings: settings) }

    it 'parsed the nameid' do
      expect(response.nameid).to eq('support@onelogin.com')
    end
    it 'have no errors' do
      expect(response.errors).to be_empty
    end
    it 'have uid attributes' do
      expect(response.attributes[:uid]).to eq('test')
    end
  end

  describe 'SAML slo logoutrequest' do
    let(:settings) { OneLogin::RubySaml::Settings.new }
    let(:logout_request) { OneLogin::RubySaml::SloLogoutrequest.new(logout_request_document) }
    before do
      settings.idp_entity_id = 'https://app.onelogin.com/saml/metadata/SOMEACCOUNT'
      settings.soft = true
      logout_request.settings = settings
      get :logout, params: { slo: 1 }
    end

    it 'have no errors' do
      expect(logout_request.errors).to be_empty
    end
    it 'return true when the logout request is initialized with valid data' do
      expect(logout_request.nameid).to eq 'someone@example.org'
    end
    it 'extract the value of the name id element' do
      expect(logout_request.nameid).to eq 'someone@example.org'
    end

    it 'return the issuer inside the logout request' do
      expect(logout_request.issuer).to eq 'https://app.onelogin.com/saml/metadata/SOMEACCOUNT'
    end

    it 'extract the value of the ID attribute' do
      expect(logout_request.id).to eq '_c0348950-935b-0131-1060-782bcb56fcaa'
    end
  end

  describe 'SAML slo logoutresponse' do
    let(:settings) { OneLogin::RubySaml::Settings.new }
    let(:logout_request) { OneLogin::RubySaml::SloLogoutrequest.new(logout_request_document) }
    before do
      settings.idp_entity_id = 'https://app.onelogin.com/saml/metadata/SOMEACCOUNT'
      settings.idp_slo_target_url = 'http://unauth.com/logout'
      settings.name_identifier_value = 'f00f00'
      settings.compress_request = true
      settings.certificate = ruby_saml_cert_text
      settings.private_key = ruby_saml_key_text
      logout_request.settings = settings
    end

    it 'support additional params' do
      unauth_url = OneLogin::RubySaml::SloLogoutresponse.new.create(
        settings,
        logout_request.id,
        nil,
        RelayState: 'http://idp.example.com'
      )
      expect(unauth_url).to match(/&RelayState=http%3A%2F%2Fidp.example.com$/)
    end

    it 'create the deflated SAMLResponse URL parameter' do
      unauth_url = OneLogin::RubySaml::SloLogoutresponse.new.create(settings, logout_request.id)
      expect(unauth_url).to include('http://unauth.com/logout?SAMLResponse=')
    end

    context '#create_params when the settings indicate to sign the logout response' do
      let(:cert) { OpenSSL::X509::Certificate.new(ruby_saml_cert_text) }

      before do
        settings.compress_response = false
        settings.security[:logout_responses_signed] = true
        settings.security[:embed_sign] = false
        settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1
      end

      let(:params) do
        OneLogin::RubySaml::SloLogoutresponse.new.create_params(
          settings,
          logout_request.id,
          nil,
          RelayState: 'http://example.com'
        )
      end

      it 'should be truthy params' do
        expect(params['SAMLResponse']).to be_truthy
        expect(params[:RelayState]).to be_truthy
        expect(params['Signature']).to be_truthy
        expect(XMLSecurity::Document::RSA_SHA1).to eq(params['SigAlg'])
      end

      it 'create a signature parameter with RSA_SHA1 and validate it' do
        query_string = "SAMLResponse=#{CGI.escape(params['SAMLResponse'])}"
        query_string << "&RelayState=#{CGI.escape(params[:RelayState])}"
        query_string << "&SigAlg=#{CGI.escape(params['SigAlg'])}"

        signature_algorithm = XMLSecurity::BaseDocument.new.algorithm(params['SigAlg'])
        expect(signature_algorithm).to eq(OpenSSL::Digest::SHA1)
        cert_verify = cert.public_key.verify(
          signature_algorithm.new,
          Base64.decode64(params['Signature']),
          query_string
        )
        expect(cert_verify).to be_truthy
      end
    end
  end
end
