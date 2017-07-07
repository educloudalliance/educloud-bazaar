module SwaggerMaterialsController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/materials' do
    operation :get do
      security do
        key :bazaar_auth
      end
      key :summary, 'Returns all materials'
      key :produces, ['application/json']
      key :tags, [
        'materials'
      ]
      response 200 do
        key :description, 'successful response'
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
  swagger_path '/api/v1/cms/materials/{id}' do
    operation :get do
      security do
        key :bazaar_auth
      end
      key :summary, 'Find material by ID'
      key :produces, ['application/json']
      key :tags, [
        'materials'
      ]
      parameter name: :id, in: :path, type: :integer do
        key :description, 'ID of material to return'
        key :required, true
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          key :'$ref', :Material
        end
      end
    end
  end
  swagger_path '/api/v1/cms/materials' do
    operation :post do
      key :summary, 'Add a new material'
      key :produces, ['application/json']
      key :tags, [
        'materials'
      ]
      parameter name: :body, in: :body do
        key :description, 'Material object that needs to be added'
        key :required, true
        schema do
          key :'$ref', :Material
        end
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :resource_uid, type: :string, example: 'eb5b7565-a3b9-487a-92ef-ed6f86976299'
        end
      end
    end
  end
  swagger_path '/api/v1/cms/materials/{id}' do
    operation :put do
      key :summary, 'Update an existing material'
      key :produces, ['application/json']
      key :tags, [
        'materials'
      ]
      parameter name: :id, in: :path, type: :integer do
        key :description, 'ID of material that needs to update'
        key :required, true
      end
      parameter name: :body, in: :body do
        key :description, 'Updated material object'
        key :required, true
        schema do
          key :'$ref', :MaterialInput
        end
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :resource_uid, type: :string, example: 'eb5b7565-a3b9-487a-92ef-ed6f86976299'
        end
      end
    end
  end
  swagger_path '/api/v1/cms/materials/{id}' do
    operation :delete do
      key :summary, 'Delete material'
      key :produces, ['application/json']
      key :tags, [
        'materials'
      ]
      parameter name: :id, in: :path, type: :integer do
        key :description, 'ID of material that needs to delete'
        key :required, true
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
        end
      end
    end
  end
end
