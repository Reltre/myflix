require 'capybara/dsl'

Capybara.default_driver = :webkit

module FeatureMacros
  def log_in(user = nil)
    user ||= Fabricate(:user)
    visit(log_in_path)
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
  end

  def admin_log_in(user = nil)
    user ||= Fabricate(:user, admin: true)
    visit(log_in_path)
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
  end

  def log_out
    visit log_out_path
  end
end
