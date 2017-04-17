require 'rails_helper'

feature "Admins Adds Video" do
  scenario "video loads video on show page", js: true do
    category = Fabricate(:category)
    admin_log_in
    expect(current_path).to eq home_path
    visit (admin_homes_path)
    expect(page).to have_text "Add a New Video"

    fill_in "Title", with: "Test Video"
    page.select category.name, from: "Category"
    fill_in "Description", with: "Test One Two"
    attach_file "large_cover_field", "#{Rails.root}/public/tmp/test_large.jpg"
    attach_file "small_cover_field", "#{Rails.root}/public/tmp/test_small.jpg"
    fill_in "Video url", with: "www.example-video.com"
    click_button "Add Video"

    expect(page).to have_text "Your video, Test Video was created."

    log_out
    log_in

    within "article.video_category" do
      click_link "Test Video"
    end
    expect(page).to have_text "Test Video"
    expect(page).to have_css("img[src='tmp/test_large.jpg']")

    click_link "Watch Now"
    expect(page).to have_css("video")
  end
end
