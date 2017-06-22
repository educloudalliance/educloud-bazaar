module Api
  module V1
    module Cms
      class ValidateController < ::Api::BaseController
        include TokenApiValidation
        before_action :validate_token

        def index
          render json: { success: 1, data: response_json(@token) }
        end

        private

        def validate_params
          params.permit(:token)
        end
      end
    end
  end
end
