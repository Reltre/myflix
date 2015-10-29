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
    
  end
end
