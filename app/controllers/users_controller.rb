class UsersController < ApplicationController
  before_action :require_login,
                only: [:show,
                       :password_reset,
                       :confirm_password_reset,
                       :forgot_password,
                       :confirm_password_reset
                      ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      AppMailer.send_welcome_email(@user).deliver
      redirect_to log_in_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def forgot_password
    render :password_page
  end

  def confirm_password_reset
    render :confirm_password_reset
  end

  def password_reset
    flash[:success] = "Your email was sent."
    current_user.generate_token
    AppMailer::Base.send_password_email(current_user.token)
    redirect_to confirm_password_reset_path
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
