class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  layout 'application'

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  end

  # Set application locales
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # def default_url_options
  #   { locale: I18n.locale }
  # end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # Catching exceptions from CanCanCan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :root, alert: exception.message
  end
end
