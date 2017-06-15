require 'rails_helper'

RSpec.describe Api::V1::Cms::ProductsController, type: :controller do
  let(:materials) { FactoryGirl.create_list(:material, 3) }
  let(:name) { FFaker::Product.product_name }
  let(:description) { FFaker::Lorem.phrase }
  let(:product) { FactoryGirl.create(:product, materials: FactoryGirl.create_list(:material, 2)) }

  describe 'POST to #create' do
    before do
      post :create, params: { name: name, description: description, material_ids: materials.map(&:id) }
    end

    context 'when all params is valid' do
      it { should respond_with(200) }
      it 'response with JSON' do
        expect(JSON(response.body)['success']).to eq(1)
        expect(JSON(response.body)['product']['materials'].size).to eq(materials.size)
      end
    end

    context 'when name param is missed' do
      let(:name) { nil }

      it { should respond_with(400) }
      it 'response with JSON about error' do
        expect(JSON(response.body)['error']).to eq('ParameterMissing')
      end
    end
  end

  describe 'PUT to #update' do
    let(:name) { 'Old name' }
    let(:description) { 'Old desc' }

    before do
      put :update, params: { id: product.id, name: name, description: description, material_ids: materials.map(&:id) }
    end

    context 'when all params is valid' do
      it { should respond_with(200) }
      it 'response with JSON' do
        expect(JSON(response.body)['success']).to eq(1)
        expect(JSON(response.body)['product']['materials'].size).to eq(materials.size)
      end
    end

    context 'when name param is missed' do
      let(:name) { '' }

      it { should respond_with(400) }
      it 'response with JSON about error' do
        expect(JSON(response.body)['error']).to eq('ParameterMissing')
      end
    end
  end

  describe 'GET to #show' do
    let(:product_id) { product.id }

    before do
      get :show, params: { id: product_id }
    end

    context 'when ID is exists in DB' do
      it { should respond_with(200) }
      it 'response with JSON' do
        expect(JSON(response.body)['id'].to_i).to eq(product.id)
        expect(JSON(response.body)['materials'].size).to eq(product.materials.size)
      end
    end

    context 'when ID is exists in DB' do
      let(:product_id) { 'fake_id' }

      it { should respond_with(404) }
      it 'response with JSON about error' do
        expect(JSON(response.body)['error']).to eq('RecordNotFound')
      end
    end
  end
end
