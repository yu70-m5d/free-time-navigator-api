# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]
  include DeviseTokenAuth::Concerns::User

  has_many :tasks
  has_many :tags, through: :tasks

  has_many :favorites
  has_many :favorite_spots, through: :favorites, source: :spot


  def favorite?(spot)
    favorite_spots.include?(spot)
  end

  def add_favorite(spot)
    favorite_spots << spot
  end

  def remove_favorite(spot)
    favorite_spots.destroy(spot)
  end

end
