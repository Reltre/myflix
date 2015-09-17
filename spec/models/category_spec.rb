require 'rails_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    let(:test_category) { Category.create(name: "drama") }

    it "returns an empty array if no videos are in the database" do
      expect(test_category.recent_videos).to eq([])
    end

    it "returns all the videos if there are less than 6 of them" do
      Video.create(title: "futurama", description: "year 3000", category: test_category)
      Video.create(title: "south park", description: "colorado funny", category: test_category)
      Video.create(title: "family guy", description: "family shenanagins",  category: test_category)

      expect(test_category.recent_videos.size).to eq(3)
    end

    it "returns 6 videos if there are more than 6 videos" do
      7.times { Video.create(title: "one piece",
                description: "pirate king",
                category: test_category) }
      expect(test_category.recent_videos.size).to eq(6)
    end

    it "returns videos in descending order by created at" do
      monk = Video.create(title: "monk", description: "detective work")
      south_park = Video.create(title: "south park", description: "colorado funny")
      futurama = Video.create(title: "family guy", description: "family shenanagins")

      test_category.videos << [south_park, monk, futurama]

      expect(test_category.recent_videos).to eq([futurama,south_park,monk])
    end

    it "returns the most recent 6 videos" do
      7.times do |video_number|
        Video.create(title: video_number,
                     description: "a video",
                     category: test_category)
      end
      expect(test_category.recent_videos).not_to include(Video.find_by_title(0))

    end
  end
end
