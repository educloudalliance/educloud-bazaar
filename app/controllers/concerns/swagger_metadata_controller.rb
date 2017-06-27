module SwaggerMetadataController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/metadata' do
    operation :get do
      key :summary, 'Returns all metadata'
      key :produces, ['application/json']
      key :tags, [
        'metadata'
      ]
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :data, type: :array do
            items type: :string
          end
        end
      end
    end
  end
  swagger_path '/api/v1/cms/metadata/{country}' do
    operation :get do
      key :summary, 'Find metadata by country'
      key :produces, ['application/json']
      key :tags, [
        'metadata'
      ]
      parameter name: :country, in: :path, type: :string do
        key :description, 'Country of metadata that needs to be fetched'
        key :required, true
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :data, type: :array do
            items type: :string
          end
        end
      end
    end
  end
end
