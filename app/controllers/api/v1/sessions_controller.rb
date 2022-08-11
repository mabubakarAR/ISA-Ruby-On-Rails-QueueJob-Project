class Api::V1::SessionsController < Devise::SessionsController
    skip_before_action :verify_signed_out_user
    before_action :sign_in_params, only: [:create]
    before_action :set_host_for_local_storage
  
    # Desc              User Sign In
    # route             POST /api/v1/sign_in
    # Access            public
    # Body              {
                            #  "user": {
                            #     "email":"abubakar@example.com",
                            #     "role": "admin",
                            #     "password":"password"
                            #    }
                        # }
    
    def create
      @user = User.find_by(email: params[:user][:email].downcase)
      if (@user.present? && @user.valid_password?(params[:user][:password]))
         render json: {
           is_success: true,
           error_code: nil,
           message: "User signed in successfully",
           token: jwt_encode(user_id: @user.id),
           result: @user
         }
      else
        if @user.present? && !@user.valid_password?(params[:user][:password])
          user_message = "Invalid password entered"
        elsif @user.present?
          user_message = @user.errors.full_messages.first
        elsif @user.blank?
          user_message = "Invalid email entered"
        end
        render json: {
            is_success: false,
            error_code: 400,
            message: user_message,
            result: nil
        }
      end
    end
  
    private
  
    def sign_in_params
      params.require(:user).permit(:role, :email, :password)
    end

    def jwt_encode(payload, exp = 7.days.from_now)
        secret_key = Rails.application.secret_key_base
        payload[:exp] = exp.to_i
        JWT.encode(payload, secret_key)
    end
  
    def set_host_for_local_storage
      ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
    end
  
  end
  