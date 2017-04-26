module Api
  module V1
    module Cms
      class MetadataController < ::Api::BaseController
        before_action :find_metadata, only: :show

        def index
          render json: metadata_fields_to_array(Metadata.all)
        end

        def show
          render json: @metadata
        end
      end
    end
  end
end
