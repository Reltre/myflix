class PasswordsController < ApplicationController
  def forgot
    render :forgot_password
  end

  def confirm
    render :confirm_password_reset
  end

  def email
    email = params[:email]
    user = User.find_by(email: email)
    if user
      user.generate_token!
      AppMailer.send_password_reset_email(user).deliver
      redirect_to confirm_password_reset_path
    else
      if email.blank?
        flash[:danger] = "You must supply an email address."
      else
        flash[:danger] = "There is no user registered with that email."
      end
      redirect_to :forgot_password
    end
  end

  def show_reset
    user = User.find_by(token: params[:token])
    if user
      @token = params[:token]
      render :new_password
    else
      redirect_to :expired_token
    end
  end

  def update
    user = User.find_by(token: params[:token])
    if user
      flash[:success] = "Your password has been changed. Please log in."
      user.update_attributes(password: params[:password], token: nil)
      redirect_to log_in_path
    else
      redirect_to :expired_token
    end
  end
end
