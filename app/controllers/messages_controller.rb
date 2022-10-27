class MessagesController < ActionController::API

  def initialize
    @message_service = MessageService.new
  end

  def create
    @message = @message_service.create(params[:application_uuid],params[:chat_number], message_params[:message])
    render json: {message_number: @message}, status: :ok
  end

  def search
    @messages = @message_service.search(params)
    render json: @messages.map {|message| message._source}, status: :ok
  end

  def show
    @messages = @message_service.show(params[:application_id], params[:chat_number])
    render json: {messages: @messages}, status: :ok
  end

  def message_params
    params.require(:message).permit(:message)
  end
end
