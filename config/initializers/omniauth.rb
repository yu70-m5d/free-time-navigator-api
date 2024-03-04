Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line, ENV["LINE_KEY"], ENV["LINE_SECRET"], {
    callback_path: '/auth/line/callback',
    provider_ignores_state: true
  }
end
