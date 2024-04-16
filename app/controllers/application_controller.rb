class ApplicationController < ActionController::Base        
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def set_storage
      @user = current_user
      @storages = @user.storages
      if params[:storage].present?
          @curr_storage = @storages.find_by(name: params[:storage])
          return
      end
      @curr_storage = @storages.first   
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
    end
end
