require 'rails_helper'

RSpec.describe Api::V1::Cms::MetadataController, type: :controller do
  let(:metadata) { create(:metadata) }
  describe 'GET #index' do
    it 'response with list of metadata' do
      get :index, format: :json
      expect(response).to have_http_status(200)
      expect(JSON(response.body)['success']).to eq(1)
      expect(JSON(response.body)['data']).to eq(Metadata.enabled.map { |m| "#{m.country}#{m.subject}" })
    end
  end

  describe 'GET #show' do
    it 'response with metadata' do
      get :show, params: { id: metadata.country }

      expect(response).to have_http_status(200)
      expect(JSON(response.body)['success']).to eq(1)
      expect(JSON(response.body)['data']).to eq(["#{metadata.country}#{metadata.subject}"])
    end

    it 'response with empty array when country not found' do
      get :show, params: { id: 'non-existent_country' }
      expect(JSON(response.body)['data']).to be_empty
    end
  end
end
