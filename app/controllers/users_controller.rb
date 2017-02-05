class UsersController < ApplicationController
  before_action :require_login, only: [:show, :invite]

  def new
    @token = params[:token]
    redirect_to root_path if @token && !Invitation.find_by(token: @token)

    @email = params[:email]
    @user = User.new
  end

  def create
    invitation = Invitation.find_by(token: params[:token])

    @user = User.new(user_params)
    if @user.save
      if invitation
        @user.following_relationships <<
          Relationship.new(leader: invitation.inviter, follower: @user)
        @user.leading_relationships <<
          Relationship.new(leader: @user, follower: invitation.inviter)
        invitation.update_attribute(:token, nil)
        flash[:success] = "You are now following #{invitation.inviter.full_name}."
      end
      AppMailer.send_welcome_email(@user).deliver
      if params[:token] && !invitation
        redirect_to expired_token_path
      else
        redirect_to log_in_path
      end
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
