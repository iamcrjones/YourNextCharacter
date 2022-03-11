class CharacterClass < ApplicationRecord
    has_many :character_sheets#, dependent: :delete_all
end
