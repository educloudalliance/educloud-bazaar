require 'rails_helper'

RSpec.describe MaterialsController, type: :controller do
  describe 'GET #index' do
    let(:materials) { Material.paginate(page: 2, per_page: 3) }

    context 'when user loggin in' do
      before do
        auth_user
        get :index
      end

      it 'assigns all materials to @materials' do
        expect(assigns(:materials).page(2)).to eq(materials)
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
        get :index
      end

      it 'redirect to login view' do
        expect(response).to redirect_to saml_index_path
      end
    end
  end

  describe 'GET #show' do
    let(:material) { FactoryGirl.create(:material) }
    before do
      auth_user
    end

    context 'when find Material' do
      before do
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