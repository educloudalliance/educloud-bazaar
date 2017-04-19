module Api
  class BaseController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound do
      render json: {error: 'RecordNotFound'}
    end

    rescue_from ActiveRecord::RecordInvalid do
      render json: {error: 'RecordInvalid'}
    end

    rescue_from ActionController::ParameterMissing do
      render json: {error: 'ParameterMissing'}
    end

    def find_material
      @material = Material.where(publisher_resource_id: params[:id]).first!
    end

    def pagination_dict(collection)
      {
        count: collection.total_pages,
        prev_url: "cms/materials?page=#{collection.previous_page}",
        next_url: "cms/materials?page=#{collection.next_page}"
      }
    end
  end
end
