require 'rails_helper'

feature "User interacts with the queue" do
  given(:category) { Fabricate(:category, name: "TV Comedies") }
  given!(:futurama) { Fabricate(:video, category: category, title: 'Futurama') }
  given!(:family_guy) { Fabricate(:video, category: category, title: 'Family Guy') }
  given!(:south_park) { Fabricate(:video, category: category, title: 'South Park') }

  scenario "user adds and reorders videos in the queue" do
    log_in

    add_video_to_queue(futurama)
    expect_video_to_be_in_queue(futurama)

    visit video_path(futurama)
    expect_link_not_to_be_seen("+ My Queue")

    add_video_to_queue(south_park)
    add_video_to_queue(family_guy)

    set_video_list_order(family_guy,1)
    set_video_list_order(south_park,2)
    set_video_list_order(futurama,3)

    update_queue

    expect_video_list_order(family_guy, 1)
    expect_video_list_order(south_park, 2)
    expect_video_list_order(futurama, 3)
  end

  def update_queue
    click_button("Update Instant Queue")
  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_text(video.title)
  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).not_to have_text(link_text)
  end

  def add_video_to_queue(video)
    visit home_path
    click_link(video.title)
    click_link('+ My Queue')
  end

  def set_video_list_order(video, list_order)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items_data_list_orders_", with: list_order
    end
  end

  def expect_video_list_order(video, list_order)
    expect(
            find(:xpath,
                 "//tr[contains(.,'#{video.title}')]//input[@type='text']"
                ).value
          ).to eq(list_order.to_s)
  end
end
