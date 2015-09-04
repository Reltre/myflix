require 'rails_helper'

describe Category, type: :model do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    before :each do
      @test_category = Category.create(name: "drama")
    end

    it "returns an empty array if no videos are in the database" do
      expect(@test_category.recent_videos).to eq([])
    end

    it "returns all the videos if there are less than 6 of them" do
      futurama = Video.create(title: "futurama", description: "year 3000")
      south_park = Video.create(title: "south park", description: "colorado funny")
      family_guy = Video.create(title: "family guy", description: "family shenanagins")

      @test_category.videos << [futurama, south_park, family_guy]
      expect(@test_category.recent_videos.size).to eq(3)
    end

    it "returns 6 videos if there are more than 6 videos" do
      7.times { Video.create(title: "one piece", description: "pirate king") }
      @test_category.videos << Video.all

      expect(@test_category.recent_videos.size).to eq(6)
    end

    it "returns videos in descending order by created at" do
      monk = Video.create(title: "monk", description: "detective work")
      south_park = Video.create(title: "south park", description: "colorado funny")
      futurama = Video.create(title: "family guy", description: "family shenanagins")

      @test_category.videos << [south_park, monk, futurama]

      expect(@test_category.recent_videos).to eq([futurama,south_park,monk])
    end

    it "returns the most recent 6 videos" do
      7.times do |video_number|
        Video.create(title: "#{video_number}", description: "a video",
         category: @test_category)
      end
      expect(@test_category.recent_videos).not_to include(Video.find_by_title(0))

    end
  end
end
