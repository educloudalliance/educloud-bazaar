require 'rails_helper'

RSpec.describe Api::V1::Lms::BrowsesController, type: :controller do
  describe 'POST lms/browse' do
    it 'save user data to session table and response with callback_url and session_id' do
      post :create, params: { first_name: 'first_name', last_name: 'last_name',
                              user_id: 'user_id', context_id: 'context_id', role: 'admin',
                              school: 'school', school_id: 'school_id', city: 'city',
                              city_id: 'city_id' }
      expect(response).to have_http_status(200)
      expect(JSON(response.body)['success']).to eq(1)
      expect(JSON(response.body)['browse_url']).to eq("#{materials_url}?session_id=#{CmsSession.last.uid}")
    end

    it 'response with record invalid' do
      post :create, params: { first_name: 'first_name' }
      expect(JSON(response.body)['error']).to eq('RecordInvalid')
    end
  end
end
