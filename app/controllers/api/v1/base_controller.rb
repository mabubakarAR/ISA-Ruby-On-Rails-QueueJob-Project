class Api::V1::BaseController < ActionController::API
    require "jwt"
    skip_before_action :authenticate_user!, raise: false
    before_action :authenticate_token!
    #skip_before_action :verify_authenticity_token
    before_action :set_host_for_local_storage
  
    private
  
    def authenticate_token!
      payload = jwt_decode(auth_token)
      @current_user ||= User.find_by_id(payload["user_id"])
      # render json: {is_success: true, error_code: 200, message: "Invalid auth token", result: nil } if @current_user.nil?
    rescue JWT::DecodeError
      render json: {is_success: false, error_code: 400, message: "Invalid auth token", result: nil }
    end
  
    def auth_token
      @auth_token ||= request.headers['Authorization']
    end

    def jwt_decode(token)
      begin
        secret_key = Rails.application.secret_key_base
        decoded = JWT.decode(token, secret_key)[0]
        HashWithIndifferentAccess.new decoded
      rescue
        return {"errors": ["Unauthorized"]}
      end
    end
  
    def set_host_for_local_storage
      ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
    end
end