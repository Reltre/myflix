class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail from: ENV['GMAIL_USERNAME'],
         to: user.email,
         subject: "Thanks for Registering With MyFlix!"
  end

  def send_password_reset_email(user)
    @token = user.token
    mail from: ENV['GMAIL_USERNAME'],
         to: user.email,
         subject: "MyFlix - Password Reset"
  end

  def send_invite_email(invitation, name)
    @token = invitation.token
    @email = invitation.email
    @message = invitation.message
    mail from: ENV['GMAIL_USERNAME'],
         to: @email,
         subject: "MyFlix - Invitation for #{name}"
  end
end
