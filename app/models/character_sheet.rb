class CharacterSheet < ApplicationRecord
  belongs_to :user
  belongs_to :character_class
  belongs_to :character_race
  #belongs_to :char_class, optional:true
  #belongs_to :char_race, optional:true
  has_one_attached :sheetupload
  accepts_nested_attributes_for :character_class
  accepts_nested_attributes_for :character_race

end
