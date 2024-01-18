class Api::V1::SpotsController < ApplicationController

  def index
    lat1 = params[:lat].to_f
    lng1 = params[:lng].to_f
    # 1.5km以内のスポットのみを取得
    @spots = Spot.within_radius_new(lat1, lng1).offset(10).includes(:tags)


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
    spots_json = @spots.as_json(include: [:tags])

    render json: spots_json

  end

  def lead
    lat1 = params[:lat].to_f
    lng1 = params[:lng].to_f
    # 1.5km以内のスポットのみを取得
    spots = Spot.within_radius_new(lat1, lng1).limit(10).includes(:tags)
    if params[:time].present?
      time = params[:time].split(":")
      hour = time[0].to_i
      minute = time[1].to_i
      total_minutes = hour * 60 + minute

      # 滞在時間が指定された時間以内のスポットのみをフィルタリング
      spots = spots.select { |spot| spot.tags.any? { |tag| tag.stay_time&. <= total_minutes } }
    end

    if params[:tags].present?
      # タグが指定された場合、該当するスポットのみをフィルタリング
      spots = spots.select { |spot| params[:tags].any? { |tag| spot.tags.pluck(:name).include?(tag) } }
    end

    spots_json = spots.as_json(include: [:tags])
    render json: spots_json
  end

  def show
    @spot = Spot.find(params[:id]).as_json(include: [:tags])
    render json: @spot
  end

end