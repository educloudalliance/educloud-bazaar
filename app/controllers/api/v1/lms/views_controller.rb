module Api
  module V1
    module Lms
      class ViewsController < ::Api::BaseController
        before_action :find_material

        def create
          cms_session = CmsSession.create(views_params)
          cms_token = CmsToken.create(
            cms_session_id: cms_session.id,
            material_id: @material.id,
            account_id: current_account.id
          )

          render json: { success: 1, view_url: "#{@material.publisher_url}?token=#{cms_token.token}" }
        end

        private

        def find_material
          @material = Material.by_viewer(views_params[:city_id], views_params[:school_id])
            .find_by!(publisher_resource_id: params[:resource_uid])
        end

        def views_params
          params.permit(:first_name, :last_name, :email, :user_id, :context_id, :context_title, :role, :school,
            :school_id, :city, :city_id, :oid)
        end
      end
    end
  end
end
