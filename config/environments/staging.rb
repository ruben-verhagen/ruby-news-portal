require_relative 'production'

Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'euro-insight.mni.demostage.me' }
  config.new_subscribers_email = 'ana@pixel-nyc.com'

  Rails.application.routes.default_url_options[:host] = 'euro-insight.mni.demostage.me'
  Rails.application.routes.default_url_options[:protocol] = 'http'
  config.log_level = :debug
end
