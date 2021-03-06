require 'rails_helper'

describe PasswordsController do
  describe "POST email" do
    context "with valid email address" do
      it "should send an email with the correct token" do
        user = Fabricate(:user)
        post :email, params: { email: user.email }
        email = ActionMailer::Base.deliveries.last
        user = User.find_by(email: user.email)
        expect(email.body.raw_source).to include(user.reload.token)
      end

      it "should redirect to confirm password page" do
        user = Fabricate(:user)
        post :email, params: { email: user.email }
        expect(response).to redirect_to confirm_password_reset_path
      end
    end

    context "with blank email address" do
      it "should set a flash message" do
        post :email, params: { email: "" }
        is_expected.to set_flash[:danger]
      end

      it "should redirect to forgot password page" do
        post :email, params: { email: "" }
        expect(response).to redirect_to forgot_password_path
      end
    end

    context "with non-existing email" do
      before { post :email, params: { email: 'example@example.com' } }

      it "should set a flash message" do
        is_expected.to set_flash[:danger]
      end

      it "should redirect to forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end
    end
  end

  describe "GET show_reset" do
    it "assigns @token" do
      user = Fabricate(:user)
      token = user.token
      get :show_reset, params: { token: token }
      expect(assigns(:token)).to eq(token)
    end

    it_behaves_like "require_token" do
      let(:action) { get :show_reset, params: { token: "hfkldsfHD4384vb" } }
    end
  end

  describe "POST update" do
    context "with valid token" do
      it "redirect to log in page" do
        user = Fabricate(:user)
        new_password = 'password1'
        token = user.token
        post :update, params: { password: new_password, token: token }
        expect(response).to redirect_to log_in_path
      end

      it "saves a new user password" do
        user = Fabricate(:user)
        new_password = 'password1'
        token = user.token
        post :update, params: { password: new_password, token: token }
        expect(user.reload.authenticate(new_password)).to eq(user)
      end

      it "should clear the token field for a user" do
        user = Fabricate(:user)
        new_password = 'password1'
        token = user.token
        post :update, params: { password: new_password, token: token }
        expect(user.reload.token).to be_nil
      end

      it "should set a flash message on successful password change" do
        user = Fabricate(:user)
        new_password = 'password1'
        token = user.token
        post :update, params: { password: new_password, token: token }
        is_expected.to set_flash[:success]
      end
    end

    it_behaves_like "require_token" do
      let(:action) { get :update, params: { token: "hfkldsfHD4384vb", password: 'password1' } }
    end
  end
end
