require 'rails_helper'

RSpec.describe MissionsController, type: :controller do

  describe "GET #accessible_agents" do
    it "returns http success" do
      get :accessible_agents
      expect(response).to have_http_status(:success)
    end
  end

end
