require 'rails_helper'

RSpec.describe Api::V1::Lms::BrowsesController, type: :request do
  let(:access_token) { create(:access_token).token }

  describe 'POST #create' do
    let(:user_id) { 'user_id' }

    before do
      post '/api/v1/lms/browse',
        params: {
          access_token: access_token, first_name: 'first_name', last_name: 'last_name',
          user_id: user_id, context_id: 'context_id', context_title: 'context_title',
          role: 'admin', school: 'school', school_id: 'school_id', city: 'city', city_id: 'city_id'
        }
    end

    context 'when all params are valid' do
      it 'responses with JSON that contain callback_url and session_id' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['success']).to eq(1)
        expect(JSON(response.body)['browse_url']).to eq(sessions_url(id: CmsSession.last.uid))
      end
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when missed requires params' do
      let(:user_id) { nil }

      it 'responses error in JSON' do
        expect(response).to have_http_status(400)
        expect(JSON(response.body)['error']).to eq('RecordInvalid')
      end
    end
  end
end
