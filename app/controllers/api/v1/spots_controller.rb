class Api::V1::SpotsController < ApplicationController
  def index
    @spots = Spot.all
    render json: @spots
  end

  def show
    @spot = Spot.find(params[:id])
    render json: @spot
  end
end
