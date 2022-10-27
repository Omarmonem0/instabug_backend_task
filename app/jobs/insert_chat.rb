class InsertChat < ApplicationJob
  queue_as :default

  def perform(application_uuid)
    ActiveRecord::Base.transaction do
      @chat = Chat.create(application_id: application_uuid, number: Chat.get_chat_number(application_uuid))
      REDIS.set("CHAT-#{@chat.application_id}-#{@chat.number}", 0)
    end
  end
end