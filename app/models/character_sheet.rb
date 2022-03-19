class CharacterSheet < ApplicationRecord
  belongs_to :user
  belongs_to :character_class
  belongs_to :character_race

  has_many :reviews, dependent: :destroy

  #Attribute for PDF file upload to AWS
  has_one_attached :sheetupload

  accepts_nested_attributes_for :character_class
  accepts_nested_attributes_for :character_race

  #Returns the average rating of a character sheet from its reviews by adding the rating of all reviews together and then dividing that number by the number of reviews.
  def average_rating
    if self.reviews.count == 0
        return 0
    end
    rating_sum = 0
    self.reviews.each do |r|
        rating_sum += r.rating
    end
    return rating_sum / self.reviews.count
  end

end
