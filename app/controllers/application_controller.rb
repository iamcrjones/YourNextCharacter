class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    #This determines if a currently signed in user has admin permissions
    def isAdmin
        if !current_user.admin
            redirect_to root_path, alert: "You do not have required permissions to access this page"
        end
    end
end
