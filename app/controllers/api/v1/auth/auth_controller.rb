class Api::V1::Auth::AuthController < ApplicationController
  def line_url
    client_id = ENV['LINE_ID']
    redirect_uri = 'https://e4ba-2001-268-c203-c91b-8d64-3e6c-a652-8eb8.ngrok-free.app/auth/line/callback'
    state = SecureRandom.hex(10) # CSRF対策のためにランダムな状態を生成
    scope = 'profile openid' # 必要に応じてスコープを設定
    bot_prompt = 'aggressive'

    line_auth_url = "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&bot_prompt=#{bot_prompt}&scope=#{scope}"
    render json: { line_auth_url: line_auth_url }
  end

  def csrf_token
    set_csrf_token
    render json: {}, status: :ok
  end
end