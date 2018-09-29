require "rails_helper"

feature "A visitor registers for MyFlix" do
  scenario "with a valid email and password", js: true do
    visit register_path
    # fill_in "Email Address", with: "example@example.com"
    # fill_in "Password", with: "password"
    # fill_in "Full Name", with: "Alison Franc"
    within_frame(0) do
      find(:xpath, './/div[@id="root"]/form[@dir="ltr"]/span/label/input')
      .set("4242424242424242", clear: :backspace)
    end
    within_frame(1) do
      find(:xpath, './/div[@id="root"]/form[@dir="ltr"]/span/label')
      .fill_in("cvc", with: "888")
    end
    within_frame(2) do
      find(:xpath, './/div[@id="root"]/form[@dir="ltr"]/span/label')
      .fill_in("exp-date", with: "0222")
    end
    # binding.pry

    expect(page).to have_text "Welcome to MyFlix!"
  end
  scenario "with a invalid email or password"
  scenario "valid credit card information"
  scenario "with invalid credit card information"
end