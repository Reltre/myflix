class InvitationsController < ApplicationController
  before_action :require_login

  def new
    @invitation = Invitation.new
  end

  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]
    invitation = Invitation.new(email: email, message: message, inviter: current_user)
    unless email.empty?
      AppMailer.send_invite_email(email, message, current_user, name).deliver
      invitation.save
      flash[:success] = "You successfully sent your invite!"
    else
      flash[:danger] = "You must provide a valid email address"
    end
    redirect_to new_invitation_path
  end
end
