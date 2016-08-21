require 'rails_helper'

feature "User navigates to the people page" do
  given!(:meredith) { Fabricate(:user, full_name: "Meredith Simmons", follower_id: user.id) }
  given!(:sam) { Fabricate(:user, full_name: "Sam Allen", follower_id: user.id) }
  given!(:user) { Fabricate(:user) }

  scenario "user unfollows another user" do
    log_in(user)
    visit people_path
    expect_page_title_to_be_seen
    unfollow(sam)
    expect_page_to_now_show(sam)
  end

  def expect_page_title_to_be_seen
    expect(page).to have_text("People I Follow")
  end

  def unfollow(a_user)
    within("//table/tbody") do
      page.find(:xpath, ".//tr/td/a[@href='/follows/#{a_user.id}']").click
    end
  end

  def expect_page_to_now_show(a_user)
    expect(page).to_not have_text "Sam Allen"
  end
end
