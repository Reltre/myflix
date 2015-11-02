require 'rails_helper'

feature "User Log In" do
  given(:user) { Fabricate(:user) }

  scenario "with correct credentials" do
    log_in(user)
    expect(current_path).to eq(home_path)
  end
end
