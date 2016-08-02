require 'rails_helper'

describe FollowsController do
  describe "GET index" do
    it "should set @users" do
      set_current_user

      joe = Fabricate(:user, full_name: "Joe", follower: current_user)
      sally = Fabricate(:user, full_name: "Sally", follower: current_user)
      get :index
      expect(assigns(:users)).to match_array([joe, sally])
    end
  end
end
