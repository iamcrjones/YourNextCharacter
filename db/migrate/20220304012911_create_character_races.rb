class CreateCharacterRaces < ActiveRecord::Migration[6.1]
  def change
    create_table :character_races do |t|
      t.string :race_name
      t.string :description
      t.string :traits

      t.timestamps
    end
  end
end
