module SwaggerMaterialModel
  include Swagger::Blocks
  swagger_schema :Material do
    property :name, type: :string
    property :description, type: :string
    property :language, type: :string
    property :publisher_resource_id, type: :integer
    property :publisher_url, type: :string
    property :metadata, type: :array do
      items type: :string
    end
    property :tags, type: :array do
      items type: :string
    end
    property :images, type: :object do
      property :type, type: :object do
        property :url, type: :string
        property :width, type: :integer
        property :height, type: :integer
      end
    end
  end
  swagger_schema :MaterialInput do
    property :name, type: :string
    property :description, type: :string
    property :language, type: :string
    property :publisher_url, type: :string
    property :metadata, type: :array do
      items type: :string
    end
    property :tags, type: :array do
      items type: :string
    end
    property :images, type: :object do
      property :type, type: :object do
        property :url, type: :string
        property :width, type: :integer
        property :height, type: :integer
      end
    end
  end
end
