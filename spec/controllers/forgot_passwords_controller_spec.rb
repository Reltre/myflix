require 'rails_helper'

describe ForgotPasswordsController do
  describe "GET password_reset" do
    it_behaves_like "require_log_in" do
      let(:action) { get :forgot_password }
    end
  end

  describe "GET confirm_password_reset" do
    it_behaves_like "require_log_in" do
      let(:action) { get :confirm_password_reset }
    end

    it "logs out the current user" do
      set_current_user
      post :confirm_password_reset
      expect(session[:user_id]).to be_nil
    end
  end

  describe "POST password_reset" do
    it_behaves_like "require_log_in" do
      let(:action) { post :password_reset }
    end

    it "should send an email with the correct token" do
      user = Fabricate(:user)
      set_current_user(user)
      post :password_reset
      email = ActionMailer::Base.deliveries.last
      expect(email.body.raw_source).to include(user.reload.token)
    end

    it "should redirect to confirm password page" do
      set_current_user
      post :password_reset
      expect(response).to redirect_to confirm_password_reset_path
    end
  end

  describe "GET new_password" do
    it "assigns @token" do
      user = Fabricate(:user)
      user.generate_token
      token = user.token
      get :new_password, token: token
      expect(assigns(:token)).to eq(token)
    end
  end

  describe "POST set_password" do
    it "redirect to log in page" do
      user = Fabricate(:user)
      new_password = 'password1'
      user.generate_token
      token = user.token
      post :set_password, params: { password: new_password, token: token }
      expect(response).to redirect_to log_in_path
    end

    it "saves a new user password" do
      user = Fabricate(:user)
      new_password = 'password1'
      user.generate_token
      token = user.token
      post :set_password, params: { password: new_password, token: token }
      expect(user.reload.authenticate(new_password)).to eq(user)
    end

    it "should clear the token field for a user" do
      user = Fabricate(:user)
      new_password = 'password1'
      user.generate_token
      token = user.token
      post :set_password, params: { password: new_password, token: token }
      expect(user.reload.token).to be_nil
    end
  end
end
