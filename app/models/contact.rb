class Contact < ApplicationRecord
  # add validates
  validates :name, presence: true
  validates :email, presence: true
  validates :subject, presence: true
  validates :message, presence: true

end
