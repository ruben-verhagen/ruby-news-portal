Rails.application.config.middleware.use OmniAuth::Builder do
  twitter = Rails.application.secrets.twitter
  provider :twitter, twitter['consumer_key'], twitter['consumer_secret']
end