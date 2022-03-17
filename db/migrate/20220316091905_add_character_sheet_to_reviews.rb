class AddCharacterSheetToReviews < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :character_sheet#, null: false, foreign_key: true
    add_foreign_key :reviews, :character_sheets, column: :character_sheet_id
  end
end
