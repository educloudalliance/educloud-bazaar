require 'rails_helper'

RSpec.describe MaterialsController, type: :controller do
  let(:cms_session) { create(:cms_session) }
  let!(:material_list) { create_list(:material, 3) }
  let(:shopping_cart) { ShoppingCart.create(cms_sessions_id: cms_session.id) }
  before(:each) do
    session[:session_id] = cms_session.uid
    session[:shopping_cart_id] = shopping_cart.id
  end
  describe 'GET #index' do
    context 'when user loggin in' do
      before do
        get :index, params: { page: 1 }
      end

      it 'assigns all materials to @materials' do
        expect(assigns(:materials)).to eq(Material.paginate(page: 1, per_page: 3))
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
    let(:material) { create(:material) }

    context 'when find Material' do
      before do
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

    context 'when Material not find' do
      before do
        get :show, params: { id: 9999 }
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
