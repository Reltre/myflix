require 'rails_helper'

feature "User navigates to the people page" do
  scenario "user follow and then unfollows another user" do
    another_user = Fabricate(:user)
    user = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video,
                      category_id: category.id,
                      title: "Adventure Time",
                      small_cover: File.new("#{Rails.root}/public/tmp/test_small.jpg")
                     )
    Fabricate(:review, user: another_user, video: video)

    log_in(user)
    navigate_to_video(video)
    expect_page_to_show(video.title)
    click_link(another_user.full_name)
    expect_page_to_show("#{another_user.full_name}'s video collection")
    click_link("Follow")
    unfollow(user, another_user)
    expect_page_to_not_show(another_user.full_name)
  end

  def navigate_to_video(video)
    find(:xpath, "//a//img[@alt='#{video.title}']/parent::node()").click
  end

  def expect_page_to_show(text)
    expect(page).to have_text(text)
  end

  def unfollow(follower, leader)
    relationship = Relationship.find_by(follower: follower, leader: leader)
    within(:xpath, "//table/tbody") do
      page
        .find(:xpath, ".//tr/td/a[@href='/relationships/#{relationship.id}']/button")
        .click
    end
  end

  def expect_page_to_not_show(text)
    expect(page).to have_no_text text
  end
end
