require 'rails_helper'

RSpec.describe FacWarSystemsController, type: :controller do

  describe "GET #refresh_fac_war_systems" do
    it "returns http success" do
      get :refresh_fac_war_systems
      expect(response).to have_http_status(:success)
    end
  end

end
