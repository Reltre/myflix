class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :logged_in?

  def set_user(user = nil)
    if user
      session[:user_id] = user.id
    else
      session[:user_id] = user
    end
  end

  def current_user
    User.find(session[:user_id]) rescue nil
  end

  def logged_in?
    !!current_user
  end
end
