require 'rails_helper'

describe Video, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:reviews).order("created_at DESC") }
  it {should validate_presence_of(:title) }
  it {should validate_presence_of(:description) }

  describe ".search_by_title" do
    it "returns an empty array is there is no match" do
      Video.create(title: "Monk", description: "detective work")
      expect(Video.search_by_title "Doctor Who").to eq([])
    end

    it "returns an array of one Video for an exact match" do
      monk = Video.new(title: "Monk", description: "detective work")
      monk.save
      expect(Video.search_by_title "Monk").to eq([monk])
    end

    it "returns an array of one Video for a partial match" do
      family_guy = Video.new(title: "Family Guy", description: "funny stuff")
      family_guy.save
      expect(Video.search_by_title "Family").to eq([family_guy])
    end

    it "returns a collection of Videos of all matches ordered by craeted at" do
      family_ties = Video.new(title: "Family Ties", description: "family time")
      family_guy = Video.new(title: "Family Guy", description: "funny stuff")
      family_guy.save and family_ties.save
      expect(Video.search_by_title "Family").to eq([family_ties, family_guy])
    end

    it "return an empty array if an empty string is the search parameter" do
      Video.create(title: "South Park", description: "colorado small town.")
      expect(Video.search_by_title "").to eq([])
    end
  end

  describe "#calculate_rating" do
    let(:video) { Fabricate(:video) }

    it "returns 0 if there are no reviews" do
      expect(video.calculate_rating).to eq(0.0)
    end

    it "returns a single integer value if there is one review" do
      review = Fabricate(:review, video: video)
      expect(video.calculate_rating).to eq(review.rating)
    end

    it "returns an average of all the ratings if there is more than one review" do
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      review3 = Fabricate(:review, video: video)
      average = (review1.rating + review2.rating + review3.rating) / 3.0
      expect(average.round(1)).to eq(video.calculate_rating)
    end
  end
end
