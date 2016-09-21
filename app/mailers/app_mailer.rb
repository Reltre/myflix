class AppMailer < ActionMailer::Base
  def notify_on_registration(user)
    mail from: ENV['GMAIL_USERNAME'], to: user.email, subject: "Thanks for Registering With MyFlix!"
  end
end
