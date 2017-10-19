require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /static_page_user" do
    it "static page user" do
      get static_page_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /static_page_setting" do
    it "static page setting" do
      get static_page_setting_path
      expect(response).to have_http_status(200)
    end
  end
end
