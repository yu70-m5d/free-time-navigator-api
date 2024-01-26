class Api::V1::SpotsController < ApplicationController

  def index
    lat1 = params[:lat].to_f
    lng1 = params[:lng].to_f

    spots = Spot.within_radius(lat1, lng1).includes(:tags)
    spots = sort_by_near_distance(spots, lat1, lng1)
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
    spots = sort_by_near_distance(spots, lat1, lng1)
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

  private

  def sort_by_near_distance(spots, lat, lng)
    spots.sort_by do |spot|
      # distance_squared(lat, lng, spot.latitude, spot.longitude)
      haversine_distance(lat, lng, spot.latitude, spot.longitude)
    end
  end

  # def distance_squared(lat1, lng1, lat2, lng2)
  #   (lat2 - lat1)**2 + (lng2 - lng1)**2
  # end

  def to_radians(degrees)
    degrees * Math::PI / 180.0
  end

  def haversine_distance(lat1, lng1, lat2, lng2)
    dlat = to_radians( lat2 - lat1 )
    dlng = to_radians( lng2 - lng1 )

    a = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
        Math.cos(to_radians(lat1)) * Math.cos(to_radians(lat2)) *
        Math.sin(dlng / 2) * Math.sin(dlng / 2)

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    r = 6371

    c * r
  end

end