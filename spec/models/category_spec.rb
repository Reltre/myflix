require 'rails_helper'

RSpec.describe Category, type: :model do
  it "saves itself" do
    comedy_hour = Category.new(name: "TV Comedies")
    comedy_hour.save
    expect(Category.first).to eq(comedy_hour)
  end

  it "has many videos" do
    drama = Category.new(name: "Drama")
    futurama = Video.new(title: "Futurama", description: "Year 3000",
                           category: drama)
    south_park = Video.new(title: "South Park", description: "Going down to..",
                          category: drama)
    drama.save!(validate: false)
    [futurama,south_park].each { |video| video.save!(validate: false) }
    expect(drama.videos).to eq( [futurama,south_park] )
  end

  it "has a name" do
    expect{Category.create!}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
