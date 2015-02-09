class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :phone_number
      t.references :sessions
    end
  end
end
