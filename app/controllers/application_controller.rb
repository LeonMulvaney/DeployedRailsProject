class ApplicationController < ActionController::Base
 # Prevent CSRF attacks by raising an exception.
 # For APIs, you may want to use :null_session instead.
 #protect_from_forgery with: :exception Comment out for Firebase
 before_action :authenticate_user!


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :clinic, :email, :password])
       devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :clinic, :email, :password])
    end
end 
