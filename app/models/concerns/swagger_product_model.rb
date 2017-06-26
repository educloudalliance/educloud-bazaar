module SwaggerProductModel
  include Swagger::Blocks
  swagger_schema :Product do
    allOf do
      schema do
        property :name, type: :string
        property :description, type: :string
        property :materials, type: :array do
          key :'$ref', :Material
        end
      end
    end
  end
  swagger_schema :ProductInput do
    property :name, type: :string
    property :description, type: :string
    property :material_ids, type: :array do
      items type: :integer
    end
  end
end
