module SwaggerMetadataModel
  include Swagger::Blocks
  swagger_schema :Metadata do
    property :country, type: :string
  end
end
