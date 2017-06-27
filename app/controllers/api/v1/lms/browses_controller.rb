module Api
  module V1
    module Lms
      class BrowsesController < ::Api::BaseController
        def create
          resource = CmsSession.new(cms_sessions_params)

          if resource.save!
            render json: response_browse_url(resource)
          end
        end

        private

        def cms_sessions_params
          params.permit(:first_name, :last_name, :email, :user_id, :context_id, :context_title, :role, :school,
            :school_id, :city, :city_id, :oid, :add_resource_callback_url, :cancel_url)
        end

        def response_browse_url(resource)
          {
            success: 1,
            browse_url: sessions_url(id: resource.uid)
          }
        end
      end
    end
  end
end
