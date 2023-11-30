class Tagging < ApplicationRecord
  # add associations
  belongs_to :spot
  belongs_to :tag
  # add validates
  validates :spot_id, presence: true
  validates :tag_id, presence: true
end
