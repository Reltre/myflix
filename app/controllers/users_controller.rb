class UsersController < ApplicationController
  before_action :require_login, only: [:show, :invite]

  def new
    @token = params[:token]
    redirect_to root_path unless User.find_by(token: @token)
    @email = params[:email]
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      token = params[:token]

      if token
        existing_user = User.find_by(token: token)
        @user.following_relationships <<
          Relationship.new(leader: existing_user, follower: @user)
        @user.leading_relationships <<
          Relationship.new(leader: @user, follower: existing_user)
        existing_user.update_attribute(:token, nil)
        flash[:success] = "You are now following #{existing_user.full_name}."
      end

      AppMailer.send_welcome_email(@user).deliver
      redirect_to log_in_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
