class Spot < ApplicationRecord
  # add validates
  validates :name, uniqueness: true
end
