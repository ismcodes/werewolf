class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :phone_number
      t.integer :session_id
    end
  end
end
