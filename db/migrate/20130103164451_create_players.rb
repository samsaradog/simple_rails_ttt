class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.string :bio
      t.string :password_digest

      t.timestamps
    end
  end
end
