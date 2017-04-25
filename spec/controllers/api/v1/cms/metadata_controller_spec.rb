require 'rails_helper'

RSpec.describe Api::V1::Cms::MetadataController, type: :controller do
  let(:metadata) { FactoryGirl.create(:metadata) }

  describe 'GET all metadata' do
    it 'response with list of metadata' do
      get :index, format: :json
      expect(response).to have_http_status(200)
      expect(response.body).not_to be_empty
      expect(JSON(response.body)['success']).to eq(1)
      expect(JSON(response.body)['data'].size).to be > 0
    end
  end

  describe 'GET metadata by country' do
    it 'response with metadata' do
      get :show, params: { id: metadata.country }

      expect(response).to have_http_status(200)
      expect(response.body).not_to be_empty
      expect(JSON(response.body)['success']).to eq(1)
      expect(JSON(response.body)['data'].size).to be > 0
    end

    it 'response with record not found' do
      get :show, params: { id: 0 }
      expect(JSON(response.body)['error']).to eq('RecordNotFound')
    end
  end
end
