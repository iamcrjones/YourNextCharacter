class CharacterRace < ApplicationRecord
    has_many :character_sheets, dependent: :destroy
end
