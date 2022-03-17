class RemoveCharacterSheetIdFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :character_sheet_id, :integer
  end
end
