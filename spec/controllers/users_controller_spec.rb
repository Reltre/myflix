require 'rails_helper'
require 'pry'

describe UsersController do

  describe "GET new" do
    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    context "new user registers through myflix invitation" do
      it "redirects to the front page when there is an invalid token" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST create" do
    it do
      params = {
        user: {
          email: 'johndoe@example.com',
          password: 'password',
          full_name: 'John Doe'
        }
      }
      post :create, params: params
      is_expected.to permit(:email, :password, :full_name)
        .for(:create, params: params).on(:user)
    end

    it "sets user" do
      post :create, params: { user: Fabricate.attributes_for(:user) }
      expect(assigns(:user)).to be_instance_of(User)
    end

    context "with valid input" do
      before { post :create, params: { user: Fabricate.attributes_for(:user) } }

      it { expect(User.count).to eq(1) }

      it { expect(response).to redirect_to log_in_path }
    end

    context "sending an email" do
      after { ActionMailer::Base.deliveries.clear }

      it "sends the email" do
        post :create, params: { user: Fabricate.attributes_for(:user), token: "token" }
        expect(ActionMailer::Base.deliveries.size).to_not eq(0)
      end

      it "has the correct message subject" do
        user_params = Fabricate.attributes_for(:user)
        post :create, params: { user: user_params }
        message = ActionMailer::Base.deliveries.last
        expect(message.subject).to eq("Thanks for Registering With MyFlix!")
      end

      it "sends the email to the correct recipient" do
        email = "may@example.com"
        user_params = Fabricate.attributes_for(:user, email: email)
        post :create, params: { user: user_params }
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([email])
      end

      it "does not send email to user with invalid input" do
        user_params = { email: "test12@email.com" }
        post :create, params: { user: user_params }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "recommended by existing user" do
      let(:existing_user) { Fabricate(:user) }
      let(:user_params) { Fabricate.attributes_for(:user) }
      let(:new_user) { User.second }
      let(:invitation) { Fabricate(:invitation, inviter: existing_user, token: "token") }

      before do
        existing_user.generate_token!
      end

      it "sets new user to as a follower of the existing user" do
        post :create, params: { user: user_params, token: invitation.token }
        expect(new_user.follows? existing_user).to be
      end

      it "sets existing user as a follower of the new user" do
        post :create, params: { user: user_params, token: invitation.token }
        expect(existing_user.follows? new_user).to be
      end

      it "deletes token from existing user" do
        post :create, params: { user: user_params, token: invitation.token }
        expect(existing_user.reload.token).to be_nil
      end

      it "sets a flash message notifying the newly registered user that they are following their friend" do
        post :create, params: { user: user_params, token: invitation.token }
        is_expected.to set_flash[:success]
      end

      it "redirects to expired token page with invalid token" do
        post :create, params: { user: user_params, token: "bad_token" }
        expect(response).to redirect_to expired_token_path
      end
    end

    context "with invalid input" do
      let(:user) { Fabricate.build(:user) }

      before do
        post :create, params:
          { user: { email: user.email, full_name: user.full_name } }
      end

      it { expect(User.count).to eq(0) }

      it { expect(response).to render_template :new }

    end
  end

  describe "GET show" do
    it_behaves_like "require_log_in" do
      let(:action) { get :show, params: { id: 3 } }
    end

    it "shoud set @user" do
      set_current_user
      user = Fabricate(:user)
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end
end
