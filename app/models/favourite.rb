class Favourite < ApplicationRecord
  belongs_to :favourited, polymorphic: true
  belongs_to :user
end
