require 'rails_helper'

feature "user views a profile page" do
  given!(:user) { Fabricate(:user) }
  given!(:comedy) { Fabricate(:category, name: "TV Comedies") }
  given!(:futurama) { Fabricate(:video, title: "Futurama", category: comedy) }
  given!(:monk) { Fabricate(:video, title: "Monk", category: comedy) }
  given!(:family_guy) do
    Fabricate(:video, title: "Family Guy", category: comedy)
  end


  scenario "has some videos queued" do
    log_in(user)
    given_videos_in_queue(user)
    visit user_path(user)
    expect_video_to_be_queued futurama.title, futurama.category.name
    expect_video_to_be_queued family_guy.title, family_guy.category.name
    expect_video_to_be_queued monk.title, monk.category.name
  end

  scenario "has some reviews" do
    log_in(user)
    given_reviews(user)
    visit user_path(user)
    given_reviews(user)
    expect_review("Futurama", 3)
    expect_review("Family Guy", 5)
  end

  def given_reviews(user)
    Fabricate(:review, video: futurama, user: user,
                content: "Futurama is great!", rating: 3)

    Fabricate(:review, video: family_guy, user: user,
              content: "Family is the best.", rating: 5)
  end

  def given_videos_in_queue(user)
    Fabricate(:queue_item, video: futurama, user: user)
    Fabricate(:queue_item, video: family_guy, user: user)
    Fabricate(:queue_item, video: monk, user: user)
  end

  def expect_review_text(text)
    expect(page).to have_text text
  end

  def expect_review(text, rating)
    rating_path = "//section[@class='user_reviews container']
//p[contains(.,'#{text}')]/following-sibling::p[1]"

    rating_content = find(:xpath, rating_path).text
    expect(rating_content).to eq("Rating: #{rating} / 5")
  end

  def expect_video_to_be_queued(title, category_name)
    expect(page).to have_text(title) && have_text(category_name)
  end
end
