class ChatsController < ActionController::API

  def initialize
    @chat_service = ChatService.new
    @application_service = ApplicationService.new
  end


  def index
    @chats = @chat_service.index(params)
    render json: @chats, status: :ok
  end

  def create
    if @application_service.is_application_exists(params[:application_id])
      @chat = @chat_service.create(params[:application_id])
      render json: @chat, status: :ok
    else
      render json: { message: "Validation failed", errors: 'Application Not Found' }, status: 404
    end
  end

end
