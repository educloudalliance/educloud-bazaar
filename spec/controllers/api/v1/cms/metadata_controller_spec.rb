require 'rails_helper'

RSpec.describe Api::V1::Cms::MetadataController, type: :request do
  let(:access_token) { create(:access_token).token }
  let(:metadata) { create(:metadata) }
  let(:country) { metadata.country }

  describe 'GET #index' do
    before do
      get '/api/v1/cms/metadata', params: { access_token: access_token }
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end

    it 'response with list of metadata' do
      expect(response).to have_http_status(200)
      expect(JSON(response.body)['success']).to eq(1)
      expect(JSON(response.body)['data']).to eq(Metadata.enabled.map { |m| "#{m.country}#{m.subject}" })
    end
  end

  describe 'GET #show' do
    before do
      get "/api/v1/cms/metadata/#{country}", params: { access_token: access_token }
    end

    context 'when request to metadata' do
      it 'response with metadata JSON' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['success']).to eq(1)
        expect(JSON(response.body)['data'])
          .to eq(Metadata.where(country: metadata.country).enabled.map { |m| "#{m.country}#{m.subject}" })
      end
    end

    context 'when not found metadata' do
      let(:country) { 'fake_country' }

      it 'response with empty JSON' do
        expect(JSON(response.body)['data']).to be_empty
      end
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
