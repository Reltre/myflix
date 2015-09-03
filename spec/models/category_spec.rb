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

    it "returns up to 6 videos for a category" do
      futurama = Video.create(title: "futurama", description: "year 3000")
      south_park = Video.create(title: "south park", description: "colorado funny")
      family_guy = Video.create(title: "family guy", description: "family shenanagins")
      @test_category.videos << [futurama, south_park, family_guy]
      expect(@test_category.recent_videos).to eq([family_guy, south_park, futurama])
    end

    it "does not return more than 6 videos" do
      7.times { Video.create(title: "one piece", description: "pirate king") }
      @test_category.videos << Video.all

      expect(@test_category.recent_videos.size).to eq(6)
    end

    it "returns videos in descending order by creation date" do
      monk = Video.create(title: "monk", description: "detective work")
      south_park = Video.create(title: "south park", description: "colorado funny")
      futurama = Video.create(title: "family guy", description: "family shenanagins")
      
      @test_category.videos << [south_park, monk, futurama]

      expect(@test_category.recent_videos[0]).to eq(futurama)
      expect(@test_category.recent_videos[1]).to eq(south_park)
      expect(@test_category.recent_videos[2]).to eq(monk)
    end
  end
end
