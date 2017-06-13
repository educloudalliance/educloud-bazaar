require 'rails_helper'

RSpec.describe ShoppingCartsController, type: :controller do
  let(:shopping_cart) { FactoryGirl.create(:shopping_cart) }
  let(:material) { FactoryGirl.create(:material) }

  describe 'Add material to the cart #create' do
    before do
      request.env['HTTP_REFERER'] = materials_url
      post :create, params: {id: material.id}, format: :json
    end

    it 'should respond with cart items count and message' do
      shopping_cart.add(material, (rand(20) + 1))
      expect(shopping_cart.cart_items.size).to eq(1)
    end
    it 'show info message' do
      expect(flash[:notice]).to be_present
    end
    it 'renders the index template' do
      expect(response).to redirect_to materials_path
    end
  end

  describe 'Show shopping cart #show' do
    before do
      get :show
    end

    let(:resources) { shopping_cart.shopping_cart_items.with_material }

    it 'should have shopping cart item with material' do
      shopping_cart.add(material, (rand(20) + 1))
      expect(resources.first.material.name).to eq(material.name)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

  describe 'remove item from cart #destroy' do
    before do
      delete :destroy, params: { id: material.id }
    end

    it 'should remove item' do
      3.times do
        shopping_cart.add(material, 22)
      end
      shopping_cart.remove(material, 1)
      expect(shopping_cart.total.to_i).to eq(44)
    end
    it 'show info message' do
      expect(flash[:alert]).to be_present
    end
    it 'redirect to cart view' do
      expect(response).to redirect_to shopping_cart_path
    end
  end
end
