require 'rails_helper'

RSpec.describe "BragDocuments", type: :request do
  describe "GET /brag_document" do
    it "returns http success" do
      get brag_document_path
      expect(response).to have_http_status(:success)
    end

    it "displays the hardcoded content" do
      get brag_document_path
      expect(response.body).to include("My Awesome Brag Document")
      expect(response.body).to include("By Gemini")
      expect(response.body).to include("This is a sample brag document showcasing my achievements and contributions to various projects.")
    end
  end
end
