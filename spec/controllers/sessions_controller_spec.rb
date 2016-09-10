require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home if user is authenticated" do
      set_current_user
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
      post :create, params: { email: user.email }
      expect(assigns(:user)).to eq(user)
    end


    context "with valid credentials" do
      before do
        user = Fabricate.attributes_for(:user)
        User.create(user)
        post :create, params: { email: user[:email], password: user[:password] }
      end

      it { should set_session[:user_id] }
      it { should set_flash[:info] }
      it { expect(response).to redirect_to home_path }
    end

    context "with invalid credentials" do
      before do
        Fabricate(:user)
        post :create
      end

      it { should_not set_session[:user_id] }
      it { should set_flash[:danger] }
      it { expect(response).to redirect_to log_in_path }
    end
  end

  describe "GET destroy" do
    before do
      set_current_user
      get :destroy
    end

    it { should set_flash[:info] }
    it { should set_session[:user_id].to nil }
    it { expect(response).to redirect_to root_path }
  end
end
