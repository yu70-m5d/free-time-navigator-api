Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line, Rails.application.credentials.line&.fetch(:line_id), Rails.application.credentials.line&.fetch(:line_secret), {
    callback_path: '/auth/line/callback',
    provider_ignores_state: true
  }
end
