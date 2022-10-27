class MessageService

  def create(application_id, chat_number, message)
    InsertMessage.perform_later(application_id, chat_number, message)
    @chat = Message.get_message_number(application_id, chat_number, false )
  end

  def show(application_id, chat_number)
    @messages = Message.where(application_id: application_id, chat_number: chat_number)
  end

  def search(params)
    @messages = (Message.search "query": {
      "bool": {
        "must": [
          {
            "match": {
              "message": params[:message]
            }
          },
          {
            "match_phrase": {
              "chat_number": params[:chat_number]
            }
          },
          {
            "match_phrase": {
              "application_id": params[:application_id]
            },
          },
        ]
      }
    }).results
  end
end