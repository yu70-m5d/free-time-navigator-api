class Spot < ApplicationRecord
  # add validates
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
