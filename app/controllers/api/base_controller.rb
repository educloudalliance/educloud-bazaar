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
      hash = { count: collection.total_pages }
      hash[:next_url] = api_v1_cms_materials_path(page: collection.next_page) if collection.next_page.present?
      hash[:prev_url] = api_v1_cms_materials_path(page: collection.previous_page) if collection.previous_page.present?
      hash
    end
  end
end
