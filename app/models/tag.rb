class Tag < ApplicationRecord
  # add associations
  has_many :taggings
  has_many :spots, through: :taggings
  # add validates
  validates :name, presence: true, uniqueness: true
end
