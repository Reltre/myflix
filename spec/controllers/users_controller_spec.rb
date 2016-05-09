require 'rails_helper'

describe UsersController do

  describe "GET new" do
    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    it { should permit(:email, :password, :full_name).for(:create) }

    it "sets user" do
      post :create, user: Fabricate.attributes_for(:user)
      expect(assigns(:user)).to be_instance_of(User)
    end

    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it { expect(User.count).to eq(1) }

      it { expect(response).to redirect_to log_in_path }
    end

    context "with invalid input" do
      let(:user) { Fabricate.build(:user) }

      before do
        post :create, user: { email: user.email, full_name: user.full_name }
      end

      it { expect(User.count).to eq(0) }

      it { expect(response).to render_template :new }

    end
  end

  describe "GET show" do
    it "shoud set @user" do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end
