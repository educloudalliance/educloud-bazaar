module Api
  module V1
    module Cms
      class MetadataController < ::Api::BaseController
        include MetadataApiHelper
        before_action :find_metadata, only: :show

        def index
          render json: metadata_fields_to_array(Metadata.enabled) if stale?(Metadata.enabled)
        end

        def show
          render json: @metadata_json if stale?(@metadata)
        end
      end
    end
  end
end
