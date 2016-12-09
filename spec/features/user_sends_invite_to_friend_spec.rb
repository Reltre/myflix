require 'rails_helper'

feature 'user_sends_invite_to_friend' do
  clear_emails
  user = Fabricate(:user, email: "example@example.com", password: '54321')

  visit log_in_path
  
end
