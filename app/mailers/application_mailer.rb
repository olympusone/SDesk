class ApplicationMailer < ActionMailer::Base
  default from: Setting.mail_server_username
  layout 'mailer'

  private

  def app_smtp_settings
    self.smtp_settings = {
        address: Setting.mail_server_host,
        port: Setting.mail_server_port,
        user_name: Setting.mail_server_username,
        password: Setting.mail_server_password,
        enable_ssl: Setting.mail_server_enable_ssl,
        authentication: Setting.mail_server_authentication,
        enable_starttls_auto: Setting.mail_server_enable_starttls_auto,
    }
  end
end
