class MembershipMailer < ApplicationMailer
  include Devise::Mailers::Helpers

  def confirmation_instructions(record, token, opts={})
    @token = token

    opts[:delivery_method_options] = app_smtp_settings
    opts[:template_path] = 'devise/mailer'

    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts={})
    @token = token

    opts[:delivery_method_options] = app_smtp_settings
    opts[:template_path] = 'devise/mailer'

    devise_mail(record, :reset_password_instructions, opts)
  end

  def unlock_instructions(record, token, opts={})
    @token = token

    opts[:delivery_method_options] = app_smtp_settings
    opts[:template_path] = 'devise/mailer'
    
    devise_mail(record, :unlock_instructions, opts)
  end

  def email_changed(record, opts={})
    opts[:delivery_method_options] = app_smtp_settings
    opts[:template_path] = 'devise/mailer'

    devise_mail(record, :email_changed, opts)
  end

  def password_change(record, opts={})
    opts[:delivery_method_options] = app_smtp_settings
    opts[:template_path] = 'devise/mailer'
    
    devise_mail(record, :password_change, opts)
  end
end
