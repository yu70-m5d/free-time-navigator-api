class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    user = current_api_v1_user
    render json: user
  end

  def show
    user = current_api_v1_user.as_json(include: [:favorite_spots])
    render json: user
  end

  def update
    if current_api_v1_user.update(user_params)
      user = current_api_v1_user.as_json(include: [:favorite_spots])
      render json: user
    else
      render json: current_api_v1_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
