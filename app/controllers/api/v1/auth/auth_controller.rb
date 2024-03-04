class Api::V1::Auth::AuthController < ApplicationController
  def line_url
    client_id = ENV['LINE_KEY']
    redirect_uri = 'https://25db-2001-268-c20e-1490-d4a2-84e0-dfd6-6a09.ngrok-free.app/auth/line/callback'
    state = SecureRandom.hex(10) # CSRF対策のためにランダムな状態を生成
    scope = 'profile openid' # 必要に応じてスコープを設定

    line_auth_url = "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"
    render json: { line_auth_url: line_auth_url }
  end

  def csrf_token
    set_csrf_token
    render json: {}, status: :ok
  end
end
