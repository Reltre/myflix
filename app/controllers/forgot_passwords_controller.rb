class ForgotPasswordsController < ApplicationController
  def forgot_password
    render :forgot_password
  end

  def confirm_password_reset
    render :confirm_password_reset
  end

  def password_reset
    email = params[:email]
    user = User.find_by(email: email)
    if user
      user.generate_token!
      AppMailer.send_password_reset_email(user).deliver
      redirect_to confirm_password_reset_path
    else
      if email.empty?
        flash[:danger] = "You must supply an email address." 
      else
        flash[:danger] = "There is no user registered with that email."
      end
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
