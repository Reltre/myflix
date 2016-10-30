require 'rails_helper'

describe ForgotPasswordsController do
  describe "POST password_reset" do
    context "with valid email address" do
      it "should send an email with the correct token" do
        user = Fabricate(:user)
        post :password_reset, params: { email: user.email }
        email = ActionMailer::Base.deliveries.last
        expect(email.body.raw_source).to include(user.reload.token)
      end

      it "should redirect to confirm password page" do
        user = Fabricate(:user)
        post :password_reset, params: { email: user.email }
        expect(response).to redirect_to confirm_password_reset_path
      end
    end

    context "with invalid email address" do
      it "should set a flash message when email is blank" do
        post :password_reset, params: { email: "" }
        is_expected.to set_flash[:danger].to "You must supply an email address."
      end
      it "should set a flash message when no user is associated with supplied email." do
        post :password_reset, params: { email: 'example@example.com' }
        is_expected.to set_flash[:danger].to "There is no user registered with that email."
      end
    end
  end

  describe "GET new_password" do
    it "assigns @token" do
      user = Fabricate(:user)
      user.generate_token!
      token = user.token
      get :new_password, token: token
      expect(assigns(:token)).to eq(token)
    end
  end

  describe "POST set_password" do
    it "redirect to log in page" do
      user = Fabricate(:user)
      new_password = 'password1'
      user.generate_token!
      token = user.token
      post :set_password, params: { password: new_password, token: token }
      expect(response).to redirect_to log_in_path
    end

    it "saves a new user password" do
      user = Fabricate(:user)
      new_password = 'password1'
      user.generate_token!
      token = user.token
      post :set_password, params: { password: new_password, token: token }
      expect(user.reload.authenticate(new_password)).to eq(user)
    end

    it "should clear the token field for a user" do
      user = Fabricate(:user)
      new_password = 'password1'
      user.generate_token!
      token = user.token
      post :set_password, params: { password: new_password, token: token }
      expect(user.reload.token).to be_nil
    end
  end
end
