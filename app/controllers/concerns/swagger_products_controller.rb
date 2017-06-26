module SwaggerProductsController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/products/{id}' do
    operation :get do
      key :description, 'Return product by ID'
      key :produces, ['application/json']
      key :tags, [
        'products'
      ]
      parameter name: :id, in: :path, type: :integer do
        key :description, 'Unique product identificator id'
        key :required, true
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          key :'$ref', :Product
        end
      end
    end
  end
  swagger_path '/api/v1/cms/products' do
    operation :post do
      key :description, 'Create product'
      key :produces, ['application/json']
      key :tags, [
        'products'
      ]
      parameter name: :product, in: :body do
        key :description, 'product parameters'
        key :required, true
        schema do
          key :'$ref', :ProductInput
        end
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :data, type: :array do
            items do
              key :'$ref', :Product
            end
          end
        end
      end
    end
  end
  swagger_path '/api/v1/cms/products/{id}' do
    operation :put do
      key :description, 'Update product by ID'
      key :produces, ['application/json']
      key :tags, [
        'products'
      ]
      parameter name: :id, in: :path, type: :integer do
        key :description, 'Unique product identificator id'
        key :required, true
      end
      parameter name: :product, in: :body do
        key :description, 'product parameters'
        key :required, true
        schema do
          key :'$ref', :ProductInput
        end
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :data, type: :array do
            items do
              key :'$ref', :Product
            end
          end
        end
      end
    end
  end
end
