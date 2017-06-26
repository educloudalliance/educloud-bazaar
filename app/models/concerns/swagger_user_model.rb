module SwaggerUserModel
  include Swagger::Blocks
  swagger_schema :User do
    property :first_name, type: :string
    property :last_name, type: :string
    property :email, type: :string
    property :user_id, type: :integer
    property :context_id, type: :integer
    property :context_title, type: :string
    property :role, type: :string
    property :school, type: :string
    property :school_id, type: :integer
    property :city, type: :string
    property :city_id, type: :string
    property :oid, type: :string
    property :country, type: :string
    property :language, type: :string
    property :instance_id, type: :string
    property :bazaar_user_id, type: :string
    property :bazaar_context_id, type: :string
    property :lsr_store, type: :string
    property :publisher_material_id, type: :string
    property :resource_uid, type: :string
    property :resource_url, type: :string
    property :organization_name, type: :string
    property :organization_id, type: :string
    property :history_id, type: :string
    property :demo, type: :integer
    property :chargeable, type: :integer
  end
end
