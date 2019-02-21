class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :fullname, :phone, :current_password) }
  end

  def append_info_to_payload(payload)
    super
    payload[:ip] = request.remote_ip
    payload[:referer] = request.referer
    payload[:user_agent] = request.user_agent
    payload[:user_id] = current_user.id if user_signed_in?
    payload[:user_name] = current_user.username if user_signed_in?
  end
end
