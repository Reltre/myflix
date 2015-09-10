require 'rails_helper'

describe SessionsController do
  let(:log_in) { session[:user_id] = Fabricate(:user).id }

  describe "GET new" do
    it "redirects to home if user is authenticated" do
      log_in
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders new template if user is not authenticated" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    it "assigns variable user" do
      user = Fabricate(:user)
      post :create, email: user.email
      expect(assigns(:user)).to eq(user)
    end

    it "redirects to home upon successful authentication" do
      user = Fabricate.build(:user)
      password = user.password
      user.save!
      post :create, email: user.email, password: password
      expect(response).to redirect_to home_path
    end

    it "redirects to log in page upon failed authentication" do
      user = Fabricate(:user)
      post :create, email: user.email, password: "failure imminent"
      expect(response).to redirect_to log_in_path
    end
  end

  describe "DELETE destroy" do
    it "redirects to front page upon log out" do
      log_in
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end
end
