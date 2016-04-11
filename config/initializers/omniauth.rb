OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :pinterest, ENV['PINTEREST_APP_ID'], ENV['PINTEREST_APP_SECRET'], provider_ignores_state: true
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], provider_ignores_state: true
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET'], provider_ignores_state: true
end
