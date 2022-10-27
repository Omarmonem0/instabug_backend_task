class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :application_id
      t.integer :chat_number
      t.integer :number
      t.text :message
      t.timestamps

      t.index [:application_id]
      t.index [:chat_number]
    end

  end
end
