class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number, unique: true
      t.string :application_id
      t.integer :messages_count, :default => 0
      t.timestamps

      t.index [:number]
    end
    add_foreign_key :chats, :applications, column: :application_id, primary_key: 'uuid'
  end
end
