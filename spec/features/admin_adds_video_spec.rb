require 'rails_helper'

feature "Admins Adds Video" do
  scenario "video is successfully added" do
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

    click_link "MyFLiX"
    click_link "Test Video"
    # Place - Render video player when "Watch Now is clicked - Test this."
  end
end
