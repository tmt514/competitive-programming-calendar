OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['RAILS_ENV'] == 'production'
    provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_app_secret, callback_url: "http://blog.icpc.tw/auth/facebook/callback"
  else
    provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_app_secret
  end
end
