require 'rails_helper'

RSpec.describe "Spaces", type: :request do
  describe "GET /spaces" do
    it "gets available spaces" do
      get spaces_path
      expect(response).to have_http_status(200)
    end
  end
end
