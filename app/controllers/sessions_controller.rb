class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      set_user(user)
      redirect_to home_path
    else
      flash[:danger] = "Invalid Username or Password"
      render :new
    end
  end

  def destroy
  #  respond_to do |format|
  #    format.html { redirect_to :root }
  #    format.js do
  #      render js: "window.location.href(#{root_path});"
  #    end
    set_user
    redirect_to :root
  end


end
