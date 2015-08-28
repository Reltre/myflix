require 'rails_helper'

RSpec.describe Video, type: :model do
  it "saves itself" do
    futurama = Video.new(title: "Futurama",
     description: "Lorem ipsum dolor sit amet",
     small_cover_url: "tmp/futurama.jpg",
     large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff")
     futurama.save

    expect(Video.first).to eq(futurama)
  end

  it "belongs to a category" do
    futurama = Video.new(title: "Futurama", description: "Year 3000")
    drama = Category.new(name: "Drama",videos: [futurama])
    futurama.save!(validate: false)
    drama.save!(validate: false)
    expect(futurama.category).to eq(drama)
  end
end
