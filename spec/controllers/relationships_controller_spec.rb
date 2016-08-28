require 'rails_helper'

describe RelationshipsController do
  describe "GET index" do
    before { set_current_user }

    it_behaves_like "require_log_in" do
      let(:action) { get :index }
    end

    it "should set @relationships" do
      joe = Fabricate(:user, full_name: "Joe Macintosh")
      sally = Fabricate(:user, full_name: "Sally Anders")
      relationship_1 = Fabricate(:relationship, leader: joe, follower: current_user)
      relationship_2 = Fabricate(:relationship, leader: sally, follower: current_user)
      get :index
      expect(assigns(:relationships))
        .to match_array([relationship_1, relationship_2])
    end
  end

  describe "POST create" do
    before { set_current_user }

    it "should redirect to the user page" do
      user = Fabricate(:user)
      post :create, params: { user: user.id }
      expect(response).to redirect_to user_path(user)
    end

    it "should create a relationship between the current user and the user they want to follow." do
      user = Fabricate(:user)
      post :create, params: { user: user.id }
      expect(current_user.following_relationships.first.leader).to eq(user)
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "require_log_in"

    it "should unfollow a user for the current user" do
      set_current_user
      joe = Fabricate(:user, full_name: "Joe Perry")
      relationship = Fabricate(:relationship, leader: joe, follower: current_user)
      delete :destroy, params: { id: relationship.id }
      expect(current_user.following_relationships.count).to eq(0)
    end

    it "redirects to the people page" do
      set_current_user
      joe = Fabricate(:user, full_name: "Joe Perry")
      relationship = Fabricate(:relationship, leader: joe, follower: current_user)
      delete :destroy, params: { id: relationship.id }
      expect(response).to redirect_to people_path
    end

    it "does not delete the relationship if the current user is not a follower" do
      set_current_user
      joe = Fabricate(:user, full_name: "Joe Perry")
      jane = Fabricate(:user, full_name: "Jane Espinoza")
      relationship = Fabricate(:relationship, leader: joe, follower: jane)
      delete :destroy, params: { id: relationship.id }
      expect(joe.leading_relationships.count).to eq 1
    end
  end
end
