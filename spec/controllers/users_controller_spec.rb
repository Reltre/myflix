require 'rails_helper'

describe UsersController do

  describe "GET new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

  end

  describe "POST create" do
    it { should permit(:email, :password, :full_name).for(:create) }

    it "assigns @user" do
      user = Fabricate.build(:user)
      post :create, user: { email: user.email,
                           password: user.password ,
                           full_name: user.full_name }
      expect(assigns(:user)).to have_attributes(email: user.email,
                                                password: user.password ,
                                                full_name: user.full_name)
    end

    it "redirects when @user saves" do
      user = Fabricate.build(:user)
      post :create, user: { email: user.email,
                           password: user.password ,
                           full_name: user.full_name }
      expect(response).to redirect_to log_in_path
    end

    it "renders new template when @user does not save" do
      user = Fabricate.build(:user)
      post :create, user: { email: user.email,
                           full_name: user.full_name }
      expect(response).to render_template :new
    end
  end
end
