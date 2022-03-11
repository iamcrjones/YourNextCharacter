class CreateCharacterSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :character_sheets do |t|
      t.references :user, null: false#, foreign_key: true
      t.references :char_class#, null: false, foreign_key: true
      t.references :char_race#, null: false, foreign_key: true
      t.string :name
      t.integer :level
      t.string :description

      t.timestamps
    end
    add_foreign_key :character_sheets, :users, column: :user_id
    add_foreign_key :character_sheets, :character_classes, column: :char_class_id
    add_foreign_key :character_sheets, :character_races, column: :char_race_id
  end
end
