module SwaggerBrowsesController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/materials' do
    operation :post do
      key :description, 'Browse and select material'
      key :produces, ['application/json']
      key :tags, [
        'browses'
      ]
      parameter name: :user, in: :body do
        key :required, true
        schema do
          key :'$ref', :User
        end
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer
          property :resource_uid, type: :integer
        end
      end
    end
  end
end
