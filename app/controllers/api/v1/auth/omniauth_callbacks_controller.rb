class Api::V1::Auth::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

  def line
    basic_action
  end

  private

  def basic_action
    @omniauth = request.env["omniauth.auth"]
    
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])

      if @profile.new_record?
        email = @omniauth['info']['email'] || "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
        @profile.assign_attributes(
          email: email,
          name: @omniauth['info']['name'],
        )

        @profile.save
      end

      sign_in(:user, @profile)

      production_uri = "https://free-time-navigator-api.onrender.com/?userId=#{@profile.id}"
      development_uri = "http://localhost:3000/?userId=#{@profile.id}"
      redirect_url = Rails.env.production? ? production_uri : development_uri

      redirect_to redirect_url, allow_other_host: true
    else

      render json: { error: "Authentication failed" }, status: :unprocessable_entity

    end
  end
end
