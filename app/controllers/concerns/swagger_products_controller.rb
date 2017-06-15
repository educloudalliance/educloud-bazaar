module SwaggerProductsController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/products' do
    operation :post do
      key :description, 'Create product'
      key :produces, ['application/json']
      # parameter name: :material, in: :body do
      #   key :required, true
      #   schema do
      #     key :'$ref', :Product
      #   end
      # end
      response 200 do
        schema type: :object do
          property :success, type: :integer
          # property :resource_uid, type: :integer
        end
      end
    end
  end
  swagger_path '/api/v1/cms/products/{id}' do
    operation :get do
      key :description, 'Return product by ID'
      key :produces, ['application/json']
      parameter :id
      response 200
      # response 200 do
      #   schema type: :object do
      #     property :data, type: :array do
      #       items do
      #         key :'$ref', :Material
      #       end
      #     end
      #   end
      # end
    end
  end
  swagger_path '/api/v1/cms/products/{id}' do
    operation :put do
      key :description, 'Update product by ID'
      key :produces, ['application/json']
      parameter :id
      # parameter name: :material, in: :body do
      #   key :required, true
      #   schema do
      #     key :'$ref', :MaterialInput
      #   end
      # end
      response 200
      # response 200 do
      #   schema type: :object do
      #     property :success, type: :integer
      #     property :resource_uid, type: :integer
      #   end
      # end
    end
  end
end
