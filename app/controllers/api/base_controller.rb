module Api
  class BaseController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound do
      render json: { error: 'RecordNotFound' }, status: 404
    end

    rescue_from ActiveRecord::RecordInvalid do
      render json: { error: 'RecordInvalid' }, status: 400
    end

    rescue_from ActionController::ParameterMissing do
      render json: { error: 'ParameterMissing' }, status: 400
    end

    def find_material
      @material = Material.find_by!(publisher_resource_id: params[:id])
    end

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

    def pagination_dict(collection)
      hash = { pages: collection.total_pages }
      hash[:next_url] = api_v1_cms_materials_url(page: collection.next_page) if collection.next_page.present?
      hash[:prev_url] = api_v1_cms_materials_url(page: collection.previous_page) if collection.previous_page.present?
      hash
    end

    def response_browse_url(resource)
      {
          success: 1,
          browse_url: "#{materials_url}?session_id=#{resource.uid}"
      }
    end
  end
end
