class CreateGameStates < ActiveRecord::Migration
  def change
    create_table :game_states do |t|
      t.string :token
      t.string :player

      t.timestamps
    end
  end
end
