class RelationshipsController < AuthenticatedController
  def index
    @following_relationships = current_user.following_relationships
  end

  def create
    user = User.find(params[:leader_id])
    if current_user.can_follow?(user)
      Relationship.create!(follower: current_user, leader: user)
    end
    redirect_to people_path
  end

  def destroy
    binding.pry
    following_relationship = Relationship.find(params[:id])
    if current_user.id == following_relationship.follower_id
      following_relationship.destroy
    end
    redirect_to people_path
  end
end
