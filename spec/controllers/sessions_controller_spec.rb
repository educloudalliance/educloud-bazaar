require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'login user' do
    before do
      @current_session = create(:cms_session)
      get :show, params: { session_id: @current_session.uid }
    end

    context 'when user loggin in' do
      it 'should save current session uid' do
        expect(session[:cms_session_id]).to eq(@current_session.uid)
      end
      it 'should save current shopping cart' do
        expect(session[:shopping_cart_id]).to eq(ShoppingCart.last.id)
      end
      it { should redirect_to(materials_path) }
    end

    context 'when user fail login' do
      before do
        get :show, params: { session_id: 'fail' }
      end

      it 'respond with error' do
        expect(JSON(response.body)['error']).to eq('Not Authorized')
      end
    end
  end
end
