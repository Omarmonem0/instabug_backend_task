require 'rails_helper'

RSpec.describe "ApplicationsControllers", type: :request do
  describe "Applications index: " do
    it "Get all applications" do
      get applications_path
      expect(response).to have_http_status(200)
    end
  end
end
