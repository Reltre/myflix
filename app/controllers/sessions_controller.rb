class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new,:create]


  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      set_user(user)
      flash[:info] = 'You are signed in, enjoy!'
      redirect_to home_path, info: 'You are signed in, enjoy!'
    else
      flash[:danger] = "Invalid Username or Password"
      redirect_to log_in_path
    end
  end

  def destroy
  #  respond_to do |format|
  #    format.html { redirect_to :root }
  #    format.js do
  #      render js: "window.location.href(#{root_path});"
  #    end
    set_user
    flash[:info] = 'You are signed out.'
    redirect_to :root
  end


end
