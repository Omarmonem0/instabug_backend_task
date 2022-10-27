class MessagesController < ActionController::API

  def initialize
    @message_service = MessageService.new
  end

  def create
    @message = @message_service.create(params[:application_uuid],params[:chat_number], message_params[:message])
    render json: @message, status: :ok
  end

  def search
    @messages = @message_service.search(params)
    render json: @messages, status: :ok
  end

  def message_params
    params.require(:message).permit(:message)
  end
end
