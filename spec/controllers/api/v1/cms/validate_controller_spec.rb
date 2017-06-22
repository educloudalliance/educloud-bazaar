require 'rails_helper'

RSpec.describe Api::V1::Cms::ValidateController, type: :request do
  let(:account) { create :account }
  let(:material) { create :material }
  let(:cms_session) { create :cms_session }
  let(:access_token) { create(:access_token, resource_owner_id: account.id).token }
  let(:cms_token) do
    create(:cms_token, account_id: account.id, cms_session_id: cms_session.id, material_id: material.id)
  end
  let(:token) { cms_token.token }

  describe 'GET to #show' do
    before do
      get "/api/v1/cms/validate/?token=#{token}", params: { access_token: access_token }
    end

    context 'when token is exists in DB' do
      it 'response with JSON' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['data']['bazaar_user_id']).to eq(cms_session.uid)
      end
    end

    context 'when token not found in DB' do
      let(:token) { 'fake_token' }

      it 'response with JSON about error' do
        expect(response).to have_http_status(404)
        expect(JSON(response.body)['error']).to eq('RecordNotFound')
      end
    end
  end

  describe 'GET to #show token validation fail' do
    context 'when is expired' do
      before do
        cms_token.update(expired_at: 1.hour.ago)
        get "/api/v1/cms/validate/?token=#{token}", params: { access_token: access_token }
      end

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
        expect(JSON(response.body)['error_message']).to eq('Token timeout')
      end
    end

    context 'when token already used' do
      before do
        cms_token.update(used: true)
        get "/api/v1/cms/validate/?token=#{token}", params: { access_token: access_token }
      end

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
        expect(JSON(response.body)['error_message']).to eq('Token already used')
      end
    end
  end
end
