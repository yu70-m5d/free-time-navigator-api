class Tag < ApplicationRecord
  # add associations
  has_many :taggings
  has_many :spots, through: :taggings

  has_many :tags
  has_many :users, through: :todos

  # add validates
  validates :name, presence: true, uniqueness: true
end
