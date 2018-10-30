# In config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET'],

    # Scopes are comma-separated list of permissions you want to request from the user. # Default scopes already in place are 'email' and 'profile'.
    {prompt: 'select_account'}
end
   