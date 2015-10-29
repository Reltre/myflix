require 'rails_helper'

feature "User interacts with the queue" do
  given(:category) do
    Fabricate(:category, name: "TV Comedies")
  end
  given!(:futurama) do
    Fabricate(:video, category: category, title: 'Futurama', description: 'Year 3000' )
  end
  given!(:south_park) do
    Fabricate(:video, category: category, title: 'Family Guy', description: 'Peuterschmidt' )
  end
  given!(:family_guy) do
    Fabricate(:video, category: category, title: 'South Park', description: 'Colorado' )
  end

  scenario "user adds and reorders videos in the queue" do
    #log in
    log_in
    # expect(current_path).to eq(home_path)
    #click the first video on home page
    click_link("Futurama")
    expect(page).to have_text("Futurama")
    #Add the video to my queue
    click_link('+ My Queue')

    expect(page).to have_text("Futurama")
    #Click link to futurama show page
    visit video_path(futurama) #consider change this to visit
    #Check that add to queue button is not rendered
    expect(page).to have_text("Futurama")
    expect(page).not_to have_text("+ My Queue")
    #Add South Park to My Queue
    visit home_path
    click_link("South Park")
    click_link('+ My Queue')
    #Add Family Guy to My Queue
    visit home_path
    click_link("Family Guy")
    click_link('+ My Queue')
    #reorder queue
    # %w(5 4 3).each_with_index do |list_order, index|
    #   fill_in "list_order_#{index + 1}" , with: list_order
    # end
    fill_in "video_#{futurama.id}" , with: 5
    fill_in "video_#{south_park.id}" , with: 4
    fill_in "video_#{family_guy.id}" , with: 3

    click_button("Update Instant Queue")
    #verify that the order has change
    expect(find("#video_#{family_guy.id}").value).to eq('1')
    expect(find("#video_#{south_park.id}").value).to eq('2')
    expect(find("#video_#{futurama.id}").value).to eq('3')
  end
end
