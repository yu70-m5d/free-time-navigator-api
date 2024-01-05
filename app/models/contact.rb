class Contact < ApplicationRecord
  # add validates
  validates :name, presence: true
  validates :email, presence: true
  validates :subject, presence: true
  validetes :message, presence: true

end
