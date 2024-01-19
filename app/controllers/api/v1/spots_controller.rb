class Api::V1::SpotsController < ApplicationController

  def index
    lat1 = params[:lat].to_f
    lng1 = params[:lng].to_f

    spots = Spot.within_radius(lat1, lng1).includes(:tags)
    spots_hash = spots.as_json(include: :tags)

    if params[:time].present?
      time = params[:time].split(":")
      hour = time[0].to_i
      minute = time[1].to_i
      total_minutes = hour * 60 + minute

      spots_hash = spots_hash.select { |spot| spot['tags'].any? { |tag| tag['stay_time'].to_i <= total_minutes } }
    end

    if params[:tags].present?
      spots_hash = spots_hash.select { |spot| spot['tags'].any? { |tag| params[:tags].include?(tag['name']) } }
    end

    spots_json = spots_hash.drop(10)
    render json: spots_json

  end

  def lead
    lat1 = params[:lat].to_f
    lng1 = params[:lng].to_f

    spots = Spot.within_radius(lat1, lng1).includes(:tags)
    spots_hash = spots.as_json(include: :tags)

    if params[:time].present?
      time = params[:time].split(":")
      hour = time[0].to_i
      minute = time[1].to_i
      total_minutes = hour * 60 + minute

      spots_hash = spots_hash.select { |spot| spot['tags'].any? { |tag| tag['stay_time'].to_i <= total_minutes } }
    end

    if params[:tags].present?
      spots_hash = spots_hash.select { |spot| spot['tags'].any? { |tag| params[:tags].include?(tag['name']) } }
    end

    spots_json = spots_hash.first(10)

    render json: spots_json
  end

  def show
    @spot = Spot.find(params[:id]).as_json(include: [:tags])
    render json: @spot
  end

end