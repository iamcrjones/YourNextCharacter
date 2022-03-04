class CreateCharacterRaces < ActiveRecord::Migration[6.1]
  def change
    create_table :character_races do |t|
      t.string :race_name,    null: false
      t.string :description,  null: false
      t.string :traits,       null: false

      t.timestamps
    end
  end
end
