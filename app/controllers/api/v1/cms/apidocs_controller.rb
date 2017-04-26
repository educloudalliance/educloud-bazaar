module Api
  module V1
    module Cms
      class ApidocsController < ::Api::BaseController
        include Swagger::Blocks
        swagger_root do
          key :swagger, '2.0'
          info do
            key :version, '1.0.0'
            key :title, 'Swagger Educloud'
            key :description, 'API that uses a Educloud in the swagger-2.0 specification'
            key :termsOfService, 'http://educloud.com/terms/'
            contact do
              key :name, 'Educloud API Team'
            end
            license do
              key :name, 'MIT'
            end
          end
          key :host, 'educloud.com'
          key :basePath, '/'
          key :consumes, ['application/json']
          key :produces, ['application/json']
          parameter :publisher_resource_id, name: :publisher_resource_id, in: :path, type: :integer do
            key :description, 'Unique material identificator publisher_resource_id'
            key :required, true
          end
          parameter :metadata_country, name: :country, in: :path, type: :string do
            key :description, 'Metadata country'
            key :required, true
          end
        end

        # A list of all classes that have swagger_* declarations.
        SWAGGERED_CLASSES = [
          SwaggerMaterialsController,
          SwaggerMaterialModel,
          SwaggerMetadataController,
          SwaggerMetadataModel,
          self
        ].freeze

        def index
          render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
        end

        def show
          swagger_data = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
          File.open('public/swagger.json', 'w') { |file| file.write(swagger_data.to_json) }
        end
      end
    end
  end
end
