require 'rails_helper'

RSpec.describe Api::V1::Cms::ProductsController, type: :request do
  let(:account) { create :account }
  let(:access_token) { create(:access_token, resource_owner_id: account.id).token }
  let(:materials) { create_list(:material, 3) }
  let(:name) { FFaker::Product.product_name }
  let(:description) { FFaker::Lorem.phrase }
  let(:product) { create(:product, materials: create_list(:material, 2)) }

  describe 'POST to #create' do
    before do
      post '/api/v1/cms/products',
        params: { access_token: access_token, name: name, description: description, material_ids: materials.map(&:id) }
    end

    context 'when all params is valid' do
      it 'response with JSON' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['success']).to eq(1)
        expect(JSON(response.body)['product']['materials'].size).to eq(materials.size)
      end
    end

    context 'when name param is missed' do
      let(:name) { nil }

      it 'response with JSON about error' do
        expect(response).to have_http_status(400)
        expect(JSON(response.body)['error']).to eq('ParameterMissing')
      end
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT to #update' do
    let(:name) { 'Old name' }
    let(:description) { 'Old desc' }

    before do
      put "/api/v1/cms/products/#{product.id}",
        params: { access_token: access_token, name: name, description: description, material_ids: materials.map(&:id) }
    end

    context 'when all params is valid' do
      it 'response with JSON' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['success']).to eq(1)
        expect(JSON(response.body)['product']['materials'].size).to eq(materials.size)
      end
    end

    context 'when name param is missed' do
      let(:name) { '' }

      it 'response with JSON about error' do
        expect(response).to have_http_status(400)
        expect(JSON(response.body)['error']).to eq('ParameterMissing')
      end
    end

    context 'when request with wrong access_token' do
      let(:access_token) { 'fake_token' }

      it 'responses with JSON with error' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET to #show' do
    let(:product_id) { product.id }

    before do
      get "/api/v1/cms/products/#{product_id}", params: { access_token: access_token }
    end

    context 'when ID is exists in DB' do
      it 'response with JSON' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['id'].to_i).to eq(product.id)
        expect(JSON(response.body)['materials'].size).to eq(product.materials.size)
      end
    end

    context 'when product not found in DB' do
      let(:product_id) { 'fake_id' }

      it 'response with JSON about error' do
        puts JSON(response.body).to_yaml
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
