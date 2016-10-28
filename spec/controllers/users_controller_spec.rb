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
        name = user_params[:full_name]
        expect(message.body.raw_source).to include(name)
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
