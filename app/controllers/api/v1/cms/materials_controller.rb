module Api
  module V1
    module Cms
      class MaterialsController < ::Api::BaseController
        before_action :find_material, only: %i[show update destroy]

        def index
          materials = Material.paginate(page: params[:page])
          if stale?(materials)
            render json: materials, meta: pagination_dict(materials), meta_key: 'pagination'
          end
        end

        def show
          render json: @material, adapter: :attribute if stale?(@material)
        end

        def create
          new_material = Material.new(create_params)
          new_material.tag_list = params[:tags]
          render json: { success: 1 } if new_material.save!
        end

        def update
          @material.tag_list = params[:tags] if params[:tags].present?
          render json: { success: 1 } if @material.update!(create_params)
        end

        def destroy
          @material.destroy!
          render json: { success: 1 }
        end

        private

        def create_params
          params.permit(:name, :description, :language, :publisher_resource_id, :publisher_url, :metadata, :image)
        end
      end
    end
  end
end
