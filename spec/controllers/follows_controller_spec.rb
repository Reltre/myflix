require 'rails_helper'

describe FollowsController do
  describe "GET index" do
    it "should set @users" do
      user = Fabricate(:user)
      set_current_user(user)

      joe = Fabricate(:user, full_name: "Joe")
      sally = Fabricate(:user, full_name: "Sally")
      user.follows = [joe, sally]

      get :index
      expect(assigns(@users)).to include_array [joe, sally]
    end
  end
end
