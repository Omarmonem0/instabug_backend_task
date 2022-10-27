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
    if @application_service.is_application_exists(params[:application_uuid])
      @chat = @chat_service.create(params[:application_uuid])
      render json: {chat_number: @chat}, status: :ok
    else
      render json: { message: "Validation failed", errors: 'Application Not Found' }, status: 400
    end
  end

end
