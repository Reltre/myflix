class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
    redirect_to home_path if logged_in?
    @email = params[:email]
  end

  def create
    @user = User.find_by_email(params[:email])
    # binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:info] = 'You are signed in, enjoy!'
      redirect_to home_path
    else
      flash[:danger] = "Invalid Username or Password"
      redirect_to log_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'You are signed out.'
    redirect_to :root
  end
end
