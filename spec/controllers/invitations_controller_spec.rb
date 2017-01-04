require 'rails_helper'

describe InvitationsController do
  describe "GET new" do
    it_behaves_like "require_log_in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it_behaves_like "require_log_in" do
      let(:action) { post :create }
    end

    it "redirects to back to invite page" do
      user = Fabricate(:user)
      friend = Fabricate(:user)
      message = "This app is awesome! You should really try it out."
      set_current_user(user)
      post :create, params:
        { name: friend.full_name, email: friend.email, message: message }
      expect(response).to redirect_to new_invitation_path
    end

    after { ActionMailer::Base.deliveries.clear }

    context "with valid email address" do
      it "creates an invitation" do
        user = Fabricate(:user)
        friend = Fabricate(:user)
        message = "This app is awesome! You should really try it out."
        set_current_user(user)
        post :create, params:
          { name: friend.full_name, email: friend.email, message: message }
        expect(Invitation.count).to eq(1)
      end

      it "shows a flash message about the success of the email" do
        user = Fabricate(:user)
        friend = Fabricate(:user)
        message = "This app is awesome! You should really try it out."
        set_current_user(user)
        post :create, params:
          { name: friend.full_name, email: friend.email, message: message }
        is_expected.to set_flash[:success]
      end

      it "sends an email with the correct message" do
        user = Fabricate(:user)
        friend = Fabricate(:user)
        message = "This app is awesome! You should really try it out."
        set_current_user(user)
        post :create, params:
          { name: friend.full_name, email: friend.email, message: message }
        email = AppMailer.deliveries.last
        expect(email.body.raw_source).to include message
      end
    end

    context "with blank email address" do
      it "shows a flash message about how the email cannot be blank" do
        user = Fabricate(:user)
        friend = Fabricate(:user)
        message = "This app is awesome! You should really try it out."
        set_current_user(user)
        post :create, params:
          { name: friend.full_name, email: "", message: message }
        is_expected.to set_flash[:danger]
      end
    end
  end
end
