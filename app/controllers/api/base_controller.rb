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

    def token_timeout_error
      render json: { success: 0, error_message: 'Token timeout', error: 401 }, status: 401
    end

    def token_used_error
      render json: { success: 0, error_message: 'Token already used', error: 401 }, status: 401
    end

    before_action :doorkeeper_authorize!

    def current_account
      Account.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def find_material
      @material = current_account.materials.find(params[:id])
    end
  end
end
