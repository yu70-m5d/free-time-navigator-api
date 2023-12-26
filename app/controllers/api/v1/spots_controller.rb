class Api::V1::SpotsController < ApplicationController

  def index
    @spots = Spot.all.includes(:tags)
    lat1 = params[:lat].to_f
    lng1 = params[:lng].to_f

    @spots = @spots.select do |spot|
      spot.within_radius?(lat1, lng1, spot.latitude, spot.longitude)
    end

    if params[:time].present?
      time = params[:time].split(":")
      hour = time[0].to_i
      minute = time[1].to_i
      total_minutes = hour * 60 + minute
      @spots = @spots.select do |spot|
        spot.tags.any? { |tag| tag.stay_time&. <= total_minutes }
      end
    end

    if params[:tags].present?
      @spots = @spots.select do |spot|
        params[:tags].any? { |tag| spot.tags.pluck(:name).include?(tag) }
      end
    end
    @spots = @spots.as_json(include: [:tags])

    render json: @spots
  end

  def show
    @spot = Spot.find(params[:id]).as_json(include: [:tags])
    render json: @spot
  end

end