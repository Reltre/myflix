class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :require_login
  helper_method :logged_in?, :current_user

  def set_user(user = nil)
    if user
      session[:user_id] = user.id
    else
      session[:user_id] = user
    end
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:info] = "You must be logged in to access that page."
      redirect_to log_in_path
    end
  end
end
