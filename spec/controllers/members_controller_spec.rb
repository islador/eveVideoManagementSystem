require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  describe "GET #add_new_api" do
    it "returns http success" do
      get :add_new_api
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #add_temporary_member" do
    it "returns http success" do
      get :add_temporary_member
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #refresh_member_list" do
    it "returns http success" do
      get :refresh_member_list
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
