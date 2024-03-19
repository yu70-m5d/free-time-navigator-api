class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    render json: current_api_v1_user.favorites
  end

  def create
    @spot = Spot.find(params[:spot_id])
    current_api_v1_user.add_favorite(@spot)
    render json: { message: "Favorite created successfully" }, status: :ok
  end

  def destroy
    @spot = current_api_v1_user.favorites.find(params[:id]).spot
    current_api_v1_user.remove_favorite(@spot)
    render json: { message: "Favorite removed successfully" }, status: :ok
  end
end
