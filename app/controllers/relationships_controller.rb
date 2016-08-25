class RelationshipsController < ApplicationController
  def index
    @following_relationships = current_user.following_relationships
  end

  def create
  end

  def destroy
    following_relationship = Relationship.find(params[:id])
    if current_user.id == following_relationship.follower_id
      following_relationship.destroy
    end
    redirect_to people_path
  end
end
