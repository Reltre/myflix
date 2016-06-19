class FollowsController < ApplicationController
  def index
    @users = current_user.follows
  end

  def create
  end

  def destroy
  end
end
