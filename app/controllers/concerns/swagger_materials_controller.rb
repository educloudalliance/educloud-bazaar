module SwaggerMaterialsController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/materials' do
    operation :get do
      key :description, 'Returns all materials from the system'
      key :produces, ['application/json']
      response 200 do
        schema type: :object do
          property :data, type: :array do
            items do
              key :'$ref', :Material
            end
          end
          property :pagination, type: :object do
            property :next_url, type: :string
            property :prev_url, type: :string
          end
        end
      end
    end
  end
  swagger_path '/api/v1/cms/materials' do
    operation :post do
      key :description, 'Create material in the system'
      key :produces, ['application/json']
      parameter name: :material, in: :body do
        key :required, true
        schema do
          key :'$ref', :Material
        end
      end
      response 200 do
        schema type: :object do
          property :success, type: :integer
          property :resource_uid, type: :integer
        end
      end
    end
  end
  swagger_path '/api/v1/cms/materials/{id}' do
    operation :get do
      key :description, 'Return material by publisher_resource_id'
      key :produces, ['application/json']
      parameter :publisher_resource_id
      response 200 do
        schema type: :object do
          property :data, type: :array do
            items do
              key :'$ref', :Material
            end
          end
        end
      end
    end
  end
  swagger_path '/api/v1/cms/materials/{id}' do
    operation :put do
      key :description, 'Update material in the system'
      key :produces, ['application/json']
      parameter :publisher_resource_id
      parameter name: :material, in: :body do
        key :required, true
        schema do
          key :'$ref', :MaterialInput
        end
      end
      response 200 do
        schema type: :object do
          property :success, type: :integer
          property :resource_uid, type: :integer
        end
      end
    end
  end
  swagger_path '/api/v1/cms/materials/{id}' do
    operation :delete do
      key :description, 'Delete material from the system'
      key :produces, ['application/json']
      parameter :publisher_resource_id
      response 200 do
        schema type: :object do
          property :success, type: :integer
        end
      end
    end
  end
end
