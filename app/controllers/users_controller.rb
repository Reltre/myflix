class UsersController < ApplicationController
  before_action :require_login, only: [:show, :invite]

  def new
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

  def invite
    @email = params[:email]
    @token = params[:token]
  end

  def send_invite
    name = params[:name]
    email = params[:email]
    message = params[:message]
    unless email.empty?
      AppMailer.send_invite_email(email, message, current_user, name).deliver
      flash[:success] = "You successfully sent your invite!"
    else
      flash[:danger] = "You must provide a valid email address"
    end
    redirect_to invite_path
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
