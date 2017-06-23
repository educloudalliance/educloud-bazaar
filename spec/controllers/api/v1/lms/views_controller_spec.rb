require 'rails_helper'

RSpec.describe Api::V1::Lms::ViewsController, type: :request do
  let(:account) { create :account }
  let(:access_token) { create(:access_token, resource_owner_id: account.id).token }

  describe 'POST #create' do
    let(:material) do
      material = create(:material)
      product = create(:product)

      create(:product_material, product: product, material: material)
      create(:license, product: product)
      material
    end

    let(:resource_uid) { material.publisher_resource_id }

    before do
      post '/api/v1/lms/view',
        params: {
          access_token: access_token, resource_uid: resource_uid,
          first_name: 'first_name', last_name: 'last_name',
          user_id: 'user_id', context_id: 'context_id', context_title: 'context_title',
          role: 'admin', school: 'school', school_id: 'school_id', city: 'city',
          city_id: 'city_id'
        }
    end

    context 'when viewer have access to material by license' do
      it 'returns JSON with view_url' do
        expect(response).to have_http_status(200)
        expect(JSON(response.body)['success']).to eq(1)
        expect(JSON(response.body)['view_url']).to eq("#{material.publisher_url}?token=#{CmsToken.last.token}")
      end
    end

    context 'when viewer does not have access to material by license' do
      let(:material) { create(:material) }
      let(:resource_uid) { 'fake_id' }

      it 'returns JSON with error' do
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
