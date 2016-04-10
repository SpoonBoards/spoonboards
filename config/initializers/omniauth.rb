OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :pinterest, ENV['PINTEREST_APP_ID'], ENV['PINTEREST_APP_SECRET'], provider_ignores_state: true
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], provider_ignores_state: true
  provider :twitter, "IkDH6jCdbyrYkm8i08cC68bKg", "zuOeb1PvAmR5KnE5AID7nHyL0EL2KLWdWpADqTh4MCZypzFYeQ",
    {
      :secure_image_url => 'true',
      :image_size => 'original',
      :authorize_params => {
        :force_login => 'true',
        :lang => 'pt'
      }
    }
end
