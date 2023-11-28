class Tag < ApplicationRecord
  has_many :spots, through: :taggings
  has_many :tags
  validates :name, presence: true, uniqueness: true
end
