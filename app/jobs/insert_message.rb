class InsertMessage < ApplicationJob
  queue_as :default

  def perform(application_id, chat_number, message)
    ActiveRecord::Base.transaction do
      @chat = Message.create(
        application_id: application_id,
        chat_number: chat_number,
        number: Message.get_message_number(application_id, chat_number),
        message: message)
    end
  end
end