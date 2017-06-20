require 'rails_helper'

RSpec.describe Api::V1::Cms::MaterialsController, type: :request do
  let(:account) { create :account }
  let(:access_token) { create(:access_token, resource_owner_id: account.id).token }
  let(:material) { create(:material, account: account) }
  let(:not_own_material) { create(:material) }
  let(:publisher_resource_id) { material.publisher_resource_id }

  describe 'GET #index' do
    before do
      create_list(:material, 2, account: account)
      create_list(:material, 3)

      get '/api/v1/cms/materials', params: { access_token: access_token }
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end

    it 'response with list of own materials' do
      expect(response).to have_http_status(200)
      expect(response.body).not_to be_empty
      expect(JSON(response.body)['data'].size).to eq(2)
    end
  end

  describe 'GET #show' do
    before do
      get "/api/v1/cms/materials/#{publisher_resource_id}", params: { access_token: access_token }
    end

    context 'when request to own meterial' do
      it 'response with material JSON' do
        expect(response).to have_http_status(200)
        expect(response.body).not_to be_empty
        expect(JSON(response.body)['publisher_resource_id']).to eq(publisher_resource_id)
      end
    end

    context 'when request to not own meterial' do
      let(:publisher_resource_id) { not_own_material.publisher_resource_id }

      it 'response with record not found' do
        expect(response).to have_http_status(404)
        expect(JSON(response.body)['error']).to eq('RecordNotFound')
      end
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST #create' do
    let(:resource_id) { SecureRandom.uuid }

    before do
      post '/api/v1/cms/materials',
        params: {
          access_token: access_token, publisher_resource_id: resource_id,
          name: FFaker::Product.name, language: FFaker::Locale.code, description: FFaker::Lorem.paragraph
        }
    end

    context 'when all params are valid' do
      it 'returns JSON' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['success']).to eq(1)
      end
    end

    context 'when params is invalid' do
      let(:resource_id) { publisher_resource_id }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(400)
        expect(JSON(response.body)['error']).to eq('RecordInvalid')
      end
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when publisher_resource_id exist in DB' do
      let(:resource_id) { publisher_resource_id }

      it 'response with JSON with error' do
        expect(response).to have_http_status(400)
        expect(JSON(response.body)['error']).to eq('RecordInvalid')
      end
    end
  end

  describe 'PUT #update' do
    before do
      put "/api/v1/cms/materials/#{publisher_resource_id}",
        params: { access_token: access_token, name: FFaker::Product.name, language: FFaker::Locale.code }
    end

    context 'when request to own meterial' do
      it 'response with JSON' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['success']).to eq(1)
      end
    end

    context 'when request to not own meterial' do
      let(:publisher_resource_id) { not_own_material.publisher_resource_id }

      it 'response with record not found' do
        expect(response).to have_http_status(404)
        expect(JSON(response.body)['error']).to eq('RecordNotFound')
      end
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete "/api/v1/cms/materials/#{publisher_resource_id}", params: { access_token: access_token }
    end

    context 'when request to own meterial' do
      it 'response with JSON' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['success']).to eq(1)
      end
    end

    context 'when request to not own meterial' do
      let(:publisher_resource_id) { not_own_material.publisher_resource_id }

      it 'response with record not found' do
        expect(response).to have_http_status(404)
        expect(JSON(response.body)['error']).to eq('RecordNotFound')
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
