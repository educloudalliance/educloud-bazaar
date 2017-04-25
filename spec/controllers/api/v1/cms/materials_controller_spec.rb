require 'rails_helper'

RSpec.describe Api::V1::Cms::MaterialsController, type: :controller do
  let(:material) { FactoryGirl.create(:material) }
  let(:publisher_resource_id) { material.publisher_resource_id }

  describe 'GET all materials' do
    it 'response with list of materials' do
      get :index, format: :json
      expect(response).to have_http_status(200)
      expect(response.body).not_to be_empty
      expect(JSON(response.body)['data'].size).to be > 0
    end
  end

  describe 'GET material' do
    it 'response with material' do
      get :show, params: { id: publisher_resource_id }

      expect(response).to have_http_status(200)
      expect(response.body).not_to be_empty
      expect(JSON(response.body)['data']['publisher_resource_id']).to eq(publisher_resource_id)
      expect(JSON(response.body)['data']['metadata'].size).to be > 0
    end

    it 'response with record not found' do
      get :show, params: { id: 0 }
      expect(JSON(response.body)['error']).to eq('RecordNotFound')
    end
  end

  describe 'POST material' do
    it 'create new material and response success 1' do
      post :create, params: { publisher_resource_id: rand(1..99),
                              name: 'name', language: 'en', description: '1' }

      expect(response).to have_http_status(200)
      expect(JSON(response.body)['success']).to eq(1)
    end

    it 'response with record invalid' do
      post :create, params: { publisher_resource_id: publisher_resource_id }
      expect(JSON(response.body)['error']).to eq('RecordInvalid')
    end
  end

  describe 'PUT material' do
    it 'update material and response success 1' do
      put :update, params: { id: publisher_resource_id, name: 'new name', language: 'fi' }

      expect(response).to have_http_status(200)
      expect(JSON(response.body)['success']).to eq(1)
    end

    it 'response with record not found' do
      put :update, params: { id: 0 }
      expect(JSON(response.body)['error']).to eq('RecordNotFound')
    end
  end

  describe 'DELETE material' do
    it 'delete material and response success 1' do
      delete :destroy, params: {id: publisher_resource_id}

      expect(response).to have_http_status(200)
      expect(JSON(response.body)['success']).to eq(1)
    end

    it 'response with record not found' do
      delete :destroy, params: { id: 0 }
      expect(JSON(response.body)['error']).to eq('RecordNotFound')
    end
  end
end
