module SwaggerValidateController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/validate/{token}' do
    operation :get do
      key :description, 'Returns user and resource data'
      key :produces, ['application/json']
      key :tags, [
        'validate'
      ]
      parameter name: :token, in: :path, type: :string do
        key :description, 'Bazaar view token'
        key :required, true
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :data, type: :array do
            items do
              key :'$ref', :User
            end
          end
        end
      end
      response 401 do
        key :description, 'error response'
        schema type: :object do
          property :'Token timeout', type: :array do
            items do
              property :success, type: :integer, example: 0
              property :error, type: :string, example: 401
              property :error_message, type: :string, example: 'Token timeout'
            end
          end
          property :'Token already used', type: :array do
            items do
              property :success, type: :integer, example: 0
              property :error, type: :string, example: 401
              property :error_message, type: :string, example: 'Token already used'
            end
          end
        end
      end
    end
  end
end
