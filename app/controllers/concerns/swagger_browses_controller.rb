module SwaggerBrowsesController
  include Swagger::Blocks
  swagger_path '/api/v1/lms/browse' do
    operation :post do
      key :description, 'Browse and select material'
      key :produces, ['application/json']
      key :tags, [
        'browses'
      ]
      parameter name: :user, in: :body do
        key :description, 'arguments'
        key :required, true
        schema do
          key :'$ref', :BrowseArgument
        end
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :browse_url, type: :string, example: 'https://bazaar.gov/?session_id=dc05e711-dac9-4b43-acd3-54c34fe397a1'
        end
      end
    end
  end
end
