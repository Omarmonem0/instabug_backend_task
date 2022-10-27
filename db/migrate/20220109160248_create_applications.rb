class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :uuid, unique: true
      t.string :name
      t.integer :chats_count, :default => 0
      t.timestamps

      t.index [:uuid]
    end
  end
end
