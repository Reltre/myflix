require "rails_helpe"

feature "A visitor registers for MyFlix" do
  scenario "with a valid email and password" do
    visit register_path
    fill_in "Email Address", with: "example@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Alison Franc"

    fill_in "cardnumber", with: "4242424242424242"
    fill_in "cvc", with: "888" 
    fill_in "exp-date", with: "0222"
  end
  scenario "with a invalid email or password"
  scenario "valid credit card information"
  scenario "with invalid credit card information"
end