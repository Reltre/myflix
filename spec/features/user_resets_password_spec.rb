require 'rails_helper'

feature "User resets their password" do
  scenario "receives reset email and logs in" do
    clear_emails
    Fabricate(:user, email: "example@example.com")

    visit forgot_password_path
    fill_in "Email", with: "example@example.com"
    click_button "Send Email"

    open_email("example@example.com")
    current_email.click_link("link")
    expect(page).to have_content "Reset Your Password"

    fill_in "New Password", with: "12345"
    click_button "Reset Password"
    expect(page).to have_text("Sign in")

    fill_in "Email Address", with: 'example@example.com'
    fill_in "Password", with: '12345'
    click_button "Log In"
    expect(page).to have_text "My Queue"
  end
end
