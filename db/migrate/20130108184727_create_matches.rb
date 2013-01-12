class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :cipher
      t.integer :player_id

      t.timestamps
    end
    add_index :matches, [:cipher]
  end
end
