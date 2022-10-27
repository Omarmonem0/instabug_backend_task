require 'elasticsearch/model'
class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.get_message_number(application_uuid, chat_number, increment = true )
    @mutex = Mutex.new
    begin
      @number_of_messages = REDIS.get("CHAT-#{application_uuid}-#{chat_number}").to_i + 1
      increment ? REDIS.set("CHAT-#{application_uuid}-#{chat_number}", @number_of_messages) : ''
    ensure
      @mutex.unlock rescue nil
    end

    @number_of_messages
  end
end
