class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_api_v1_user!


  def create
    @spot = Spot.find(params[:spot_id].to_i)
    current_api_v1_user.add_favorite(@spot)
  end

  def destroy
    @spot = current_api_v1_user.favorites.find(params[:id]).spot
    current_api_v1_user.remove_favorite(@spot)
  end
end
