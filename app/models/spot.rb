class Spot < ApplicationRecord
  # add associations
  has_many :taggings
  has_many :tags, through: :taggings
  # add validates
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :place_id, presence: true, uniqueness: true

  def self.within_radius(lat, lng)

    # 緯度経度がFloat型であることを確認
    unless lat.is_a?(Float) && lng.is_a?(Float)
      raise ArgumentError, "Invalid latitude or longitude"
    end

    # 緯度経度をラジアンに変換
    lat_rad = lat * Math::PI / 180
    lng_rad = lng * Math::PI / 180

    # 1.5kmの距離に相当する緯度経度の差を計算
    delta_lat = 1.5 / 6371.0 * (180 / Math::PI)
    delta_lng = 1.5 / (6371.0 * Math.cos(lat_rad)) * (180 / Math::PI)

    # 指定範囲内のスポットを取得
    spots_within_radius = where(
      latitude: (lat - delta_lat)..(lat + delta_lat),
      longitude: (lng - delta_lng)..(lng + delta_lng)
    )
  end

end
