class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  layout :application_layout
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
  
  def application_layout
    current_user ? "signed_in" : "application"
  end
  
  
end
