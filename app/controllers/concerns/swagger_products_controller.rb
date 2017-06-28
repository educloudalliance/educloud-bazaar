module SwaggerProductsController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/products/{id}' do
    operation :get do
      key :summary, 'Find product by ID'
      key :produces, ['application/json']
      key :tags, [
        'products'
      ]
      parameter name: :id, in: :path, type: :integer do
        key :description, 'ID of product that needs to be fetched'
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
      key :summary, 'Add a new product'
      key :produces, ['application/json']
      key :tags, [
        'products'
      ]
      parameter name: :body, in: :body do
        key :description, 'Product object that needs to be added'
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
      key :summary, 'Update an existing product'
      key :produces, ['application/json']
      key :tags, [
        'products'
      ]
      parameter name: :id, in: :path, type: :integer do
        key :description, 'ID of product that needs to update'
        key :required, true
      end
      parameter name: :body, in: :body do
        key :description, 'Updated product object'
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
