require 'rails_helper'

feature "My Queue", type: :request do
  background do
    Fabricate(:user,
              email: 'kalin_borges@example.com',
              password: 'password',
              full_name: 'Kalin Borges')
    category = Fabricate(:category, name: "TV Comedies")
    Fabricate(:video, category: category, title: 'Futurama', description: 'Year 3000' )
    Fabricate(:video, category: category, title: 'Family Guy', description: 'Peuterschmidt' )
    Fabricate(:video, category: category, title: 'South Park', description: 'Colorado' )
  end


  scenario "log in and add, remove and reorder videos to my queue" do
    #log in
    visit(log_in_path)
    fill_in "Email Address", with: 'kalin_borges@example.com'
    fill_in "Password", with: 'password'
    click_button "Log In"
    expect(current_path).to eq(home_path)
    #click the first video on home page
    click_link("Futurama")
    #Add the video to my queue
    click_link('+ My Queue')
    expect(current_path).to eq(my_queue_path)
    #Click link to futurama show page
    click_link("Futurama")
    #Check that add to queue button is not rendered
    expect(page).to have_text("Futurama")
    expect(page).not_to have_text("+ My Queue")
    #Add South Park to My Queue
    click_link("Videos")
    click_link("South Park")
    click_link('+ My Queue')
    #Add Family Guy to My Queue
    click_link("Videos")
    click_link("Family Guy")
    #change order of queue items
    click_link('+ My Queue')
    %w(5 4 3).each_with_index do |list_order, index|
      fill_in "list_order_#{index + 1}" , with: list_order
    end
    click_button("Update Instant Queue")
    #verify that the order has change
    list_orders = []
    3.times do |index|
      list_orders << find("#list_order_#{index + 1}").value
    end
    expect(list_orders).to eq(["1","2","3"])
  end
end
