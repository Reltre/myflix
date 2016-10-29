class ForgotPasswordsController < ApplicationController
  before_action :require_login,
                only: [:password_reset,
                       :confirm_password_reset,
                       :forgot_password,
                       :confirm_password_reset
                      ]

  def forgot_password
    render :forgot_password
  end

  def confirm_password_reset
    session[:user_id] = nil
    render :confirm_password_reset
  end

  def password_reset
    user = User.find_by(email: params[:email])
    if user
      user.generate_token
      AppMailer.send_password_reset_email(user).deliver
      redirect_to confirm_password_reset_path
    else
      flash[:danger] = "There is no user registered with that email."
      render :forgot_password
    end
  end

  def new_password
    @token = params[:token]
    render :new_password
  end

  def set_password
    user = User.find_by(token: params[:token])
    user.update_attributes(password: params[:password], token: nil)
    redirect_to log_in_path
  end
end
