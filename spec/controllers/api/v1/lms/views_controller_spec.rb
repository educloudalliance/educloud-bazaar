require 'rails_helper'

RSpec.describe Api::V1::Lms::ViewsController, type: :controller do
  describe 'POST #create' do
    let(:material) { create(:material) }
    it 'find material and return publisher_url' do
      post :create, params: { first_name: 'first_name', last_name: 'last_name',
                              user_id: 'user_id', context_id: 'context_id', role: 'admin',
                              school: 'school', school_id: 'school_id', city: 'city',
                              city_id: 'city_id', resource_uid: material.publisher_resource_id }
      expect(response).to have_http_status(200)
      expect(JSON(response.body)['success']).to eq(1)
      expect(JSON(response.body)['view_url']).to eq(material.publisher_url)
    end

    it 'Not found material' do
      post :create, params: { resource_uid: 0 }
      expect(response).to have_http_status(404)
      expect(JSON(response.body)['error']).to eq('RecordNotFound')
    end
  end
end
