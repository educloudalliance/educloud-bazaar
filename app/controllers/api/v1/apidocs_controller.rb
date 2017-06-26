module Api
  module V1
    class ApidocsController < ActionController::API
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
        tag name: 'materials' do
          key :description, 'Materials operations'
        end
        tag name: 'metadata' do
          key :description, 'Metadata operations'
        end
        tag name: 'products' do
          key :description, 'Products operations'
        end
        tag name: 'validate' do
          key :description, 'Validate view token'
        end
        tag name: 'browses' do
          key :description, 'Browse and select material operations'
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
        SwaggerProductModel,
        SwaggerProductsController,
        SwaggerValidateController,
        SwaggerUserModel,
        SwaggerBrowsesController,
        self
      ].freeze

      def index
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET'
        headers['Access-Control-Allow-Headers'] = 'Content-Type, api_key, Authorization'
        render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
      end

      def show
        swagger_data = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
        File.open('public/swagger.json', 'w') { |file| file.write(swagger_data.to_json) }
      end
    end
  end
end
