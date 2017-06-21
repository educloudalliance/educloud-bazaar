module MetadataApiHelper
  def find_metadata
    @metadata = Metadata.where(country: params[:id]).enabled
    @metadata_json = metadata_fields_to_array(@metadata)
  end

  def metadata_fields_to_array(collection)
    hash = { success: 1 }
    hash[:data] = collection.map do |metadata|
      "#{metadata.country}#{metadata.subject}"
    end
    hash
  end
end
