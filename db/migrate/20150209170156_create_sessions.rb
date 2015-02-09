class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :uuid
    end
  end
end
