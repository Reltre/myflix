require 'rails_helper'

feature "User navigates to the people page" do
  given!(:meredith) { Fabricate(:user, full_name: "Meredith Simmons") }
  given!(:sam) { Fabricate(:user, full_name: "Sam Allen") }
  given!(:user) { Fabricate(:user) }
  given!(:relationship_1) { Fabricate(:relationship, leader: sam, follower: user) }
  given!(:relationship_2) { Fabricate(:relationship, leader: meredith, follower: user) }


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
      page
        .find(:xpath, ".//tr/td/a[@href='/relationships/#{relationship_1.id}']")
        .click
    end
  end

  def expect_page_to_now_show(a_user)
    expect(page).to_not have_text "Sam Allen"
  end
end
