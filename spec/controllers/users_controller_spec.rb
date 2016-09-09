require 'rails_helper'

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
