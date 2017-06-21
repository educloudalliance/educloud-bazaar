require 'rails_helper'

RSpec.describe MaterialsController, type: :controller do
  let(:cms_session) { create(:cms_session) }
  let(:shopping_cart) { ShoppingCart.create(cms_sessions_id: cms_session.id) }
  let(:product) { create(:product) }
  let(:not_public_product) { create(:product) }

  before(:each) do
    session[:session_id] = cms_session.uid
    session[:shopping_cart_id] = shopping_cart.id
  end

  describe 'GET #index' do
    before(:each) do
      # Public materials
      create(:license, product: product)
      create_list(:material, 2).each do |material|
        create(:product_material, product: product, material: material)
      end

      # Not public materials
      create(:license, product: not_public_product, school_id: 123, city_id: 321)
      create_list(:material, 3).each do |material|
        create(:product_material, product: not_public_product, material: material)
      end
    end

    context 'when user loggin in' do
      before do
        get :index
      end

      it 'assigns all materials to @materials' do
        expect(assigns(:materials)).to eq(Material.by_viewer(nil, nil).order(id: :asc).to_a)
      end
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end
      it 'renders the index template' do
        expect(response).to render_template('index')
      end
    end

    context 'when user fail login' do
      before do
        get :index, params: { page: 2 }, session: { session_id: nil, shopping_cart_id: nil }
      end

      it 'respond with error' do
        expect(JSON(response.body)['error']).to eq('Not Authorized')
      end
    end
  end

  describe 'GET #show' do
    let(:shopping_cart) { create(:shopping_cart) }
    let(:material) do
      material = create(:material)
      create(:product_material, product: product, material: material)
      material
    end

    context 'when viewer have license on material' do
      before do
        create(:license, product: product, city_id: cms_session.city_id, school_id: cms_session.school_id)
        session[:shopping_cart_id] = shopping_cart.id

        get :show, params: { id: material.id }
      end

      it 'find Material by id' do
        expect(assigns(:material)).to eq(material)
      end
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end
      it 'renders the show template' do
        expect(response).to render_template('show')
      end
    end

    context 'when viewer does not have license on material' do
      before do
        get :show, params: { id: material.id }
      end

      it 'show error message' do
        expect(flash[:alert]).to be_present
      end
      it 'redirect to materials view' do
        expect(response).to redirect_to materials_path
      end
    end
  end
end
