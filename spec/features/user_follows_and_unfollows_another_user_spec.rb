require 'rails_helper'

feature "User navigates to the people page" do
  given!(:user) { Fabricate(:user) }
  given!(:bigglesworth) { User.find_by(full_name: "Mr. Bigglesworth") }

  scenario "user unfollows another user" do
    log_in(user)
    navigate_to_video('Futurama')
    expect_page_to_show("Futurama")
    click_link(bigglesworth.full_name)
    expect_page_to_show("#{bigglesworth.full_name}'s video collection")
    click_link("Follow")
    unfollow(bigglesworth)
    expect_page_to_now_show(bigglesworth.full_name)
  end

  def navigate_to_video(video)
    find(:xpath, "//a//img[@alt='#{video}']/parent::node()").click
  end

  def expect_page_to_show(text)
    expect(page).to have_text(text)
  end

  def unfollow(leader)
    relationship = Relationship.find_by(follower: user, leader: leader)
    within("//table/tbody") do
      page
        .find(:xpath, ".//tr/td/a[@href='/relationships/#{relationship.id}']")
        .click
    end
  end

  def expect_page_to_now_show(text)
    expect(page).to_not have_text text
  end
end
