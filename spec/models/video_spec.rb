require 'rails_helper'

describe Video, type: :model do
  it { should belong_to(:category) }
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
end
