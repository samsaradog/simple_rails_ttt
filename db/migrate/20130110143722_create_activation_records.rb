class CreateActivationRecords < ActiveRecord::Migration
  def change
    create_table :activation_records do |t|
      t.boolean :active, default: false
      t.string :token
      t.integer :player_id

      t.timestamps
    end
    add_index :activation_records, [:token]
  end
end
