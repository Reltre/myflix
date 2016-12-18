require 'rails_helper'

feature 'User sends invite to friend' do
  scenario "friend signs up for myflix" do
    user = Fabricate(:user, email: "example@example.com", password: '54321')
    log_in(user)
    click_link "Invite a Friend!"
    fill_in "Friend's Name", with: "Jenny Anders"
    fill_in "Friend's Email Address", with: "jennytime@example.com"
    fill_in "Invitation Message", with: "Hey, check out this great movie site, it's amazing!"
    click_button "Send Invitation"
    open_email("jennytime@example.com")
    current_email.click_link('MyFlix - Signup')
    expect(page).to have_xpath ("//input[@value='jennytime@example.com']")
    fill_in 'Password', with: '12345'
    fill_in 'Full Name', with: 'Jenny Anders'
    click_button 'Sign Up'
    fill_in "Email Address", with: "jennytime@example.com"
    fill_in "Password", with: "12345"
    click_button "Log In"
    expect(page).to have_content "Welcome, Jenny Anders"
    clear_emails
  end
end
