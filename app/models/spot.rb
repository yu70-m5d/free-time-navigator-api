class Spot < ApplicationRecord
  # add associations
  has_many :taggings
  has_many :tags, through: :taggings
  # add validates
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  def within_radius?(lat1, lng1, lat2, lng2)
    radius = 1.5
    distance = haversine_distance(lat1, lng1, lat2, lng2)
    distance <= radius
  end

  private

  def haversine_distance(lat1, lng1, lat2, lng2)
    # 地球の半径（単位:km）
    radius = 6371

    # 緯度経度をラジアンに変換
    lat1_rad, lng1_rad, lat2_rad, lng2_rad = [lat1, lng1, lat2, lng2].map { |coord| deg2rad(coord) }

    # 差の計算
    dlat = lat2_rad - lat1_rad
    dlng = lng2_rad - lng1_rad

    # はバーサインの公式に基づく距離の計算
    a = Math.sin(dlat / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlng / 2) ** 2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    # 距離（単位:km）
    distance = radius * c
  end

  def deg2rad(deg)
    deg * Math::PI / 180
  end

end
