class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :character_sheet
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :character_sheet
end
