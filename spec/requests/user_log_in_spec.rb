require 'rails_helper'

feature "User Log In", type: :request do
  background do
    Fabricate(:user,
              email: 'kalin_borges@example.com',
              password: 'password',
              full_name: 'Kalin Borges')
  end

  scenario "with correct credentials" do
    visit(log_in_path)
    fill_in "Email Address", with: 'kalin_borges@example.com'
    fill_in "Password", with: 'password'
    click_button "Log In"
    expect(current_path).to eq(home_path)
  end

  scenario "with incorrect credentials" do
    visit(log_in_path)
    fill_in "Email Address", with: 'cookie_monster@example.com'
    fill_in "Password", with: 'cooookkies'
    click_button "Log In"
    expect(current_path).to eq(log_in_path)
  end
end
