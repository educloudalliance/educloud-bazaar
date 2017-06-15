class ProductSerializer < ActiveModel::Serializer
  type nil

  attributes :id, :name, :description

  has_many :materials
end
