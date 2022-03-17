class AddCharacterSheetIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :character_sheet_id, :integer
  end
end
