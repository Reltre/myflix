class UsersController < ApplicationController
  before_action :require_login, only: [:show, :invite]

  def new
    @token = params[:token]
    redirect_to root_path if @token && !Invitation.find_by(token: @token)

    @email = params[:email]
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # handle_invitation
      handle_charge
      # AppMailer.send_welcome_email(@user.id).deliver_later
      redirect_to log_in_path
    else
      # flash[:error] = @user.errors.full_messages.join("\n")
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

  def handle_charge
    # binding.pry
    begin
      customer = Stripe::Customer.create(
        :email   => @user.email,
        :source  => params[:stripeToken]
      )
      
      charge = StripeWrapper::Charge.create(
        :amount      => 999,
        :customer    => customer.id,
        :description => "Sign up charge for #{@user.email}",
        :card        => params[:stripeToken]
      )
    rescue Stripe::CardError => e
      flash[:error] = chare.error_message
      render :new
    end
  end

  def handle_invitation
    invitation = Invitation.find_by(token: params[:token])
    return unless invitation
    redirect_to expired_token_path if params[:token] && !invitation
    @user.following_relationships <<
      Relationship.new(leader: invitation.inviter, follower: @user)
    @user.leading_relationships <<
      Relationship.new(leader: @user, follower: invitation.inviter)
    invitation.update_attribute(:token, nil)
    flash[:success] = "You are now following #{invitation.inviter.full_name}."
  end
end
