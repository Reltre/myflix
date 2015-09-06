class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      set_user(user)
      redirect_to home_path
    else
      flash[:danger] = "Invalid Username or Password"
      render :new
    end
  end

  def front
  end

  def destroy
    respond_to do |format|
      format.html
      format.js { set_user }
    end
    redirect_to :root
  end

  private

  def set_user(user = nil)
    if session[:user_id]
      session[:user_id] = user
    else
      session[:user_id] = user.id
    end
  end

  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end
