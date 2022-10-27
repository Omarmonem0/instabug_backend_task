class ApplicationsController < ActionController::API

    def initialize
        @application_service = ApplicationService.new
    end

    def index
        @applications = @application_service.index()
        render json: @applications, status: :ok
    end

    def show
        @application = @application_service.show(params[:uuid])
        render json: @application, status: :ok
    end

    def create
        @application = @application_service.create(application_params)
        if @application.save
            render json: @application, status: :created
        else
            render json: @application.errors, status: :unprocessable_entity
        end
    end

    private

    def application_params
        params.require(:application).permit(:name)
    end
end
