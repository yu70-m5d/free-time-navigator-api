class Task < ApplicationRecord

  belongs_to :user
  belongs_to :tag, optional: true

  validates :user_id, presence: true
end
