class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates_uniqueness_of :user_id, scope: :spot_id
end
