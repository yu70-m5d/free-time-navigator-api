class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController

  def create
    user_id = sign_in_params[:user_id]
    if user_id
      @resource = User.find_by(id: user_id)
      if @resource
        @token_data = @resource.create_token
        @resource.save!
        render json: { userId: @resource.id, client: @token_data.client, token: @token_data.token, uid: @resource.uid, provider: @resource.provider }
      end
    end
  end

  private

  def sign_in_params
    params.require(:session).permit(:user_id, :email, :password)
  end
end
