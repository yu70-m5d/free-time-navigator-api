class Api::V1::Auth::AuthController < ApplicationController
  def line_url
    client_id = Rails.application.credentials.line&.fetch(:line_id)
    development_uri = 'https://3f05-2001-268-c204-1b09-495e-8686-fb22-ce6d.ngrok-free.app/auth/line/callback'
    production_uri = 'https://free-time-navigator-api.onrender.com/auth/line/callback'
    state = SecureRandom.hex(10) # CSRF対策のためにランダムな状態を生成
    scope = 'profile openid' # 必要に応じてスコープを設定

    redirect_uri = Rails.env.production? ? production_uri : development_uri


    line_auth_url = "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"
    render json: { line_auth_url: line_auth_url }
  end

  def csrf_token
    set_csrf_token
    render json: {}, status: :ok
  end
end
