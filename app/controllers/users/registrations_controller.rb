# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({})
    self.resource.user = Requester.new
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource params.require(:user).permit(:email, :password, :password_confirmation)

    if resource.email.present?
      resource.user = Requester.new params.require(:user).permit(user:[:name, :lastname])[:user]

      if Company.exists? domain: resource.email.split('@').last
        resource.user.company = Company.find_by_domain resource.email.split('@').last

        if resource.user.valid?
          resource.save
          yield resource if block_given?
          if resource.persisted?
            if resource.active_for_authentication?
              set_flash_message! :notice, :signed_up
              sign_up(resource_name, resource)
              respond_with resource, location: login_path
            else
              set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
              expire_data_after_sign_in!
              respond_with resource, location: login_path
            end
          else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
          end
        else
          resource.errors.add :base, 'Please fill properly all user inputs!'
          render :new
        end
      else
        resource.errors.add :base, 'There is no company with such email suffix address!'
        render :new
      end
    else
      super
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, user_attributes:[:name, :lastname]])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    login_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
