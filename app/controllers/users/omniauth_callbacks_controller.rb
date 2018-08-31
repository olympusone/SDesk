# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  # def all
  #   auth_params = request.env["omniauth.auth"]
  #
  #   if auth_params.info.email.present?
  #     user = User.from_omniauth auth_params
  #
  #     if user.present?
  #       sign_in user
  #       set_flash_message(:notice, :success, kind: t("enumerize.identity.provider.#{request.env['omniauth.auth'].provider}")) if is_navigational_format?
  #       redirect_to user.role?(:user) ? user_path(user) : root_path
  #     else
  #       redirect_to new_user_registration_path, alert: t('devise.failure.unauthenticated')
  #     end
  #   else
  #     redirect_to new_user_registration_path, alert: t('devise.omniauth_callbacks.email_not_provided', kind: auth_params.provider.capitalize)
  #   end
  # end
  #
  # alias_method :facebook, :all
  # alias_method :twitter, :all # FIXME not working yet
  # alias_method :google_oauth2, :all
  # alias_method :twitch, :all
  # alias_method :steam, :all
  # alias_method :vkontakte, :all
end
