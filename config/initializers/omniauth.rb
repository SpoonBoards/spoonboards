Rails.application.config.middleware.use OmniAuth::Builder do
  provider :pinterest, ENV['PINTEREST_APP_ID'], ENV['PINTEREST_APP_SECRET']
end
