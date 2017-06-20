module Api
  module V1
    module Lms
      class ViewsController < ::Api::BaseController
        def create
          render json: { success: 1, view_url: publisher_url }
        end

        private

        def publisher_url
          Material.find_by!(publisher_resource_id: params[:resource_uid]).publisher_url
        end

        def views_params
          params.permit(:first_name, :last_name, :email, :user_id, :context_id, :context_title, :role, :school,
            :school_id, :city, :city_id, :oid, :resource_uid, :return_url)
        end
      end
    end
  end
end
