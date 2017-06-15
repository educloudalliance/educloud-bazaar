module Api
  module V1
    module Cms
      class ProductsController < ::Api::BaseController
        before_action :find_product, only: %i[show update]

        def create
          product = Product.new(product_params)

          render json: { success: 1, product: product }, include: :materials if product.save!
        end

        def update
          render json: { success: 1, product: @product }, include: :materials if @product.update!(product_params)
        end

        def show
          render json: @product, adapter: :attribute if stale?(@product)
        end

        private

        def product_params
          params.require(:name)
          params.permit(:name, :description, material_ids: [])
        end

        def find_product
          @product = Product.find(params[:id])
        end
      end
    end
  end
end
