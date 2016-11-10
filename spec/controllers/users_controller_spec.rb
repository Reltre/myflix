require 'rails_helper'
require 'pry'

describe UsersController do

  describe "GET new" do
    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
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
        post :create, params: { user: Fabricate.attributes_for(:user) }
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

  describe "GET invite" do
    it_behaves_like "require_log_in" do
      let(:action) { get :invite }
    end
  end

  describe "POST send_invite" do
    it_behaves_like "require_log_in" do
      let(:action) { get :invite }
    end

    after { ActionMailer::Base.deliveries.clear }

    context "with valid email address" do
      it "redirects to back to invite page" do
        post :send_invite
        expect(response).to redirect_to invite_path
      end

      it "shows a flash message about the success of the email" do
        post :send_invite
        is_expected.to set_flash[:success]
      end

      it "sends an email with the correct message" do
        user = Fabricate(:user)
        friend = Fabricate(:user)
        message = "This app is awesome! You should really try it out."
        set_current_user(user)
        post :send_invite, params:
          { name: friend.full_name, email: friend.email, message: message }
        email = AppMailer.deliveries.last
        expect(email.body.raw_source).to include message
      end
    end

    context "with blank email address" do
    end


  end
end
