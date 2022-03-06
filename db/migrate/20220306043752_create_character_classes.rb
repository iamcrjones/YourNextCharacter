class CreateCharacterClasses < ActiveRecord::Migration[6.1]
  def change
    create_table :character_classes do |t|
      t.string :charclass_name, null: false
      t.string :description, null: false
      t.string :bis_stats, null: false

      t.timestamps
    end
  end
end
