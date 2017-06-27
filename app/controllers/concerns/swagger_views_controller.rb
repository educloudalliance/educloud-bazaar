module SwaggerViewsController
  include Swagger::Blocks
  swagger_path '/api/v1/lms/view' do
    operation :post do
      key :summary, 'Viewing material'
      key :produces, ['application/json']
      key :tags, [
        'views'
      ]
      parameter name: :body, in: :body do
        key :description, 'User object for views selected material'
        key :required, true
        schema do
          key :'$ref', :ViewArgument
        end
      end
      response 200 do
        key :description, 'successful response'
        schema type: :object do
          property :success, type: :integer, example: 1
          property :browse_url, type: :string, example: 'https://bazaar.gov/validate?token=df0ae5a63ab170f69706301d4d5b0356a0e800108b9e2fed26e36116b88cce28'
        end
      end
    end
  end
end
