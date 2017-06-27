require 'rails_helper'

RSpec.describe MaterialsController, type: :controller do
  let(:cms_session) { create(:cms_session) }
  let(:shopping_cart) { ShoppingCart.create(cms_session_id: cms_session.id) }
  let(:product) { create(:product) }
  let(:not_public_product) { create(:product) }

  before(:each) do
    session[:cms_session_id] = cms_session.id
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
      it { should respond_with(200) }
    end

    context 'when user unauthorized' do
      before do
        get :index, params: { page: 1 }, session: { cms_session_id: nil }
      end

      it 'assigns all materials to @materials' do
        expect(assigns(:materials)).to eq(Material.by_viewer(nil, nil).order(id: :asc).to_a)
      end
      it { should respond_with(200) }
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
        get :show, params: { id: material.id }
      end

      it 'find Material by id' do
        expect(assigns(:material)).to eq(material)
      end

      it { should respond_with(200) }
    end

    context 'when viewer does not have license on material' do
      before do
        get :show, params: { id: material.id }
      end

      it { should set_flash[:alert] }
      it { should redirect_to(materials_path) }
    end
  end
end
