class InvitationsController < AuthenticatedController
  def new
    @invitation = Invitation.new
  end

  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]
    invitation = Invitation.new(email: email, message: message, inviter: current_user)
    if invitation.save
      AppMailer.send_invite_email(invitation.id, name).deliver_later
      flash[:success] = "You successfully sent your invite!"
    else
      flash[:danger] = "You must provide a valid email address"
    end
    redirect_to new_invitation_path
  end
end
