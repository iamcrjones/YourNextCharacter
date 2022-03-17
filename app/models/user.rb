class User < ApplicationRecord
  has_many :reviews
  has_many :character_sheets
  has_many :favourites
  has_many :favourite_character_sheets, through: :favourites, source: :favourited, source_type: 'CharacterSheet'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
