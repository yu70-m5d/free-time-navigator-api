class Api::V1::SpotsController < ApplicationController
  def index
    lat1 = params[:lat].to_f
    lng1 = params[:lng].to_f
    # lat1 = 35.5505809
    # lng1 = 139.4455242
    @spots = Spot.all
    @spots_within_radius = @spots.select do |spot|
      spot.within_radius?(lat1, lng1, spot.latitude, spot.longitude)
    end
    render json: @spots_within_radius
  end

  def show
    @spot = Spot.find(params[:id])
    render json: @spot
  end
end
