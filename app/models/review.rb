class Review < ApplicationRecord
    belongs_to :user
    belongs_to :character_sheet
    accepts_nested_attributes_for :character_sheet
end
