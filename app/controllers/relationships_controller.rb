class RelationshipsController < ApplicationController
  def index
    @following_relationships = current_user.following_relationships
  end

  def create
    user = User.find(params[:user])

    relationship = Relationship.new(follower: current_user, leader: user)
    unless relationship.save
      flash[:info] = "You're already following this user."
    end
    redirect_to user_path(user.id)
  end

  def destroy
    following_relationship = Relationship.find(params[:id])
    if current_user.id == following_relationship.follower_id
      following_relationship.destroy
    end
    redirect_to people_path
  end
end
