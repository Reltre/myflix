class FollowsController < ApplicationController
  def index
    @users = current_user.follows
  end

  def create
  end

  def destroy
    follow = User.where(id: params[:id], follower_id: current_user.id).first
    follow.update_attribute :follower_id, nil
    redirect_to people_path
  end
end
