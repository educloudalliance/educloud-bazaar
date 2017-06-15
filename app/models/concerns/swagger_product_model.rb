module SwaggerProductModel
  include Swagger::Blocks
  swagger_schema :Product do
    property :name, type: :string
    property :description, type: :string
    property :materials, type: :array do
      items type: :string
    end
  end
  swagger_schema :ProductInput do
    property :name, type: :string
    property :description, type: :string
    property :material_ids, type: :array do
      items type: :int
    end
  end
end
