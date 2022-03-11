class CharacterSheet < ApplicationRecord
  belongs_to :user
  # has_one :char_class
  # has_one :char_race
  belongs_to :char_class, optional:true
  belongs_to :char_race, optional:true
  has_one_attached :sheetupload
  accepts_nested_attributes_for :char_class
  accepts_nested_attributes_for :char_race

end
