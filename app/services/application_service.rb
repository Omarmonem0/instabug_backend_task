class ApplicationService
  def index()
    @applications = Application.all
  end

  def create(params)
    @application = Application.create(params)
  end

  def show(uuid)
    @application = Application.find_by_uuid(uuid)
  end

  def update(uuid, params)
    @application = Application.find(uuid)
    @application.update(params)

    @application
  end

  def is_application_exists(uuid)
    @application_exists = Application.exists?(:uuid => uuid)
  end

end