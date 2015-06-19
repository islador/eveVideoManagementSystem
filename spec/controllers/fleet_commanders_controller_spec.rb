require 'rails_helper'

RSpec.describe FleetCommandersController, type: :controller do
  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in user
  end
  let(:fleet_commander) {FactoryGirl.create(:fleet_commander)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: fleet_commander.id
      expect(response).to have_http_status(:success)
    end

    it "returns the fleet commander" do
      get :show, id: fleet_commander.id
      expect(assigns(:fleet_commander)).to eq(fleet_commander)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "creates a new fleet commander object" do
    end

    it "creates a character object tuple from the user's data" do
    end
  end

  describe "GET #create" do
    xit "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id:  fleet_commander.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    xit "returns http success" do
      put :update, id: fleet_commander.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    context "fleet commander is found" do
      it "deletes the fleet commander" do
        delete :destroy, id: fleet_commander.id
        expect(FleetCommander.where(id: fleet_commander.id).empty?).to be == true
      end

      it "sets the flash to inform the user the FC was deleted." do
        delete :destroy, id: fleet_commander.id
        expect(flash[:notice]).to_not be_nil
      end

      it "redirects the user" do
        post :destroy, id: fleet_commander.id
        expect(response).to have_http_status(:redirect)
      end
    end

    context "fleet commander is not found" do
      it "sets the flash to inform the user the FC was not found." do
        delete :destroy, id: 22
        expect(flash[:alert]).to_not be_nil
      end

      it "redirects the user" do
        post :destroy, id: 22
        expect(response).to have_http_status(:redirect)
      end
    end
  end

end
