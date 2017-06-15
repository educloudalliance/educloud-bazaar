class MaterialSerializer < ActiveModel::Serializer
  attributes :name, :description, :language, :publisher_resource_id, :publisher_url,
    :publisher_data, :metadata, :tags, :images
  type 'data'

  has_many :metadata do
    object.metadata.where(metadata: { enabled: true }).map do |m|
      "#{m.country}#{m.subject}"
    end
  end

  def tags
    object.tag_list
  end

  def images
    hash = {}
    object.image.styles.as_json.each do |image|
      size = image.second['geometry'].split('x')
      hash[image.first.to_s] = {
          url: object.image.url(image.first.to_s),
          height: size.first.to_i,
          width: size.second.to_i
      }
    end
    hash
  end
end
