require 'rails_helper'

RSpec.describe "Quests", type: :request do
  describe "POST /quests" do
    context "with valid parameters" do
      it "creates a new Quest" do
        expect do
          post quests_url, params: { quest: attributes_for(:quest) }, as: :turbo_stream
        end.to change(Quest, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Quest" do
        expect do
          post quests_url, params: { quest: attributes_for(:quest, name: nil) }, as: :turbo_stream
        end.to change(Quest, :count).by(0)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /quests/:id/toggle" do
    it "toggles the status of the quest" do
      quest = create(:quest, status: false)
      patch toggle_quest_url(quest), as: :turbo_stream
      quest.reload
      expect(quest.status).to be(true)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /quests/:id" do
    it "destroys the requested quest" do
      quest = create(:quest)
      expect do
        delete quest_url(quest), as: :turbo_stream
      end.to change(Quest, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get quests_url
      expect(response).to have_http_status(:success)
    end

    it "displays all quests" do
      quest1 = create(:quest, name: "First Quest")
      quest2 = create(:quest, name: "Second Quest")

      get quests_url
      expect(response.body).to include(quest1.name)
      expect(response.body).to include(quest2.name)
    end
  end
end