class ChatService

  def index(params)
    @applications = Chat.where(application_id: params[:application_uuid])
  end

  def create(application_uuid)
    InsertChat.perform_later(application_uuid)
    @chat = Chat.get_chat_number(application_uuid, false )
  end

  def is_chat_exists(application_uuid, chat_number)
    @chat_exists = Chat.exists?(:application_id => application_uuid, :number => chat_number)
  end
end