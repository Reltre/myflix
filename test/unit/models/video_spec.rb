require 'rails_helper'

RSpec.describe Video do
  it "saves itself" do
    futurama = Video.new(title: "Futurama",
     description: "Lorem ipsum dolor sit amet",
     small_cover_url: "tmp/futurama.jpg",
     large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff")
     futurama.save

    expect(Video.first).to eq(futurama)
  end
end
