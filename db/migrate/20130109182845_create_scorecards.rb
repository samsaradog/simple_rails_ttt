class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
      t.integer :player_id
      t.integer :games_won
      t.integer :games_lost
      t.integer :draw_games

      t.timestamps
    end
    add_index :scorecards, [:player_id]
  end
end
