require 'rails_helper'

describe 'OAuthToken', type: :request do
  describe 'POST to /oauth/token' do
    context 'when grant type is client_credentials' do
      let(:oauth_application) { create(:oauth_application) }

      context 'when client_id and client_secret valid' do
        it 'responds with access_token' do
          post '/oauth/token',
            params: {
              grant_type: 'client_credentials',
              client_id: oauth_application.uid,
              client_secret: oauth_application.secret
            }

          expect(response.response_code).to eq(200)
          response_data = JSON.parse(response.body)
          expect(response_data['token_type']).to eq('bearer')
          expect(response_data['access_token']).to_not be_nil
          expect(response_data['created_at']).to_not be_nil
        end
      end

      context 'when client_id is invalid' do
        it 'responds with error' do
          post '/oauth/token', params: { client_id: 'fake client_id', client_secret: oauth_application.secret }

          expect(response.response_code).to eq(401)
          response_data = JSON.parse(response.body)
          expect(response_data['error']).to eq('invalid_request')
        end
      end

      context 'when client_secret is invalid' do
        it 'responds with error' do
          post '/oauth/token', params: { client_id: oauth_application.uid, client_secret: 'fake client_secret' }

          expect(response.response_code).to eq(401)
          response_data = JSON.parse(response.body)
          expect(response_data['error']).to eq('invalid_request')
        end
      end
    end
  end
end
