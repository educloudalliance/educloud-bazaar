module SwaggerMetadataController
  include Swagger::Blocks
  swagger_path '/api/v1/cms/metadata' do
    operation :get do
      key :description, 'Returns all metadata from the system'
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
      key :description, 'Return metadata by country'
      key :produces, ['application/json']
      key :tags, [
        'metadata'
      ]
      parameter :metadata_country
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
