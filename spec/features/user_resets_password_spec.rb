require 'rails_helper'

feature "User resets their password" do
  scenario "user successfully resets their password" do
    clear_emails
    user = Fabricate(:user, password: '54321')

    visit log_in_path
    click_link "Forgot Password?"
    fill_in "Email", with: user.email
    click_button "Send Email"

    open_email(user.email)
    binding.pry
    current_email.click_link("link")
    expect(page).to have_content "Reset Your Password"

    fill_in "New Password", with: "12345"
    click_button "Reset Password"
    expect(page).to have_text("Log in")

    fill_in "Email Address", with: user.email
    fill_in "Password", with: '12345'
    click_button "Log In"
    expect(page).to have_text "Welcome, #{user.full_name}"
  end
end
