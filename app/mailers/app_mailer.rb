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

  def send_invite_email(name, email, referer)
    @token = referer.generate_token!
    @friend_name = name
    @name = current_user.full_name
    mail from: ENV['GMAIL_USERNAME'],
         to: email,
         subject: "MyFlix - Invitation"
  end
end
