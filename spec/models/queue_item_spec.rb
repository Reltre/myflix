require 'rails_helper'

describe QueueItem do
  it { should belong_to :video }
  it { should belong_to :user }

  it { should validate_presence_of :video }
  it { should validate_presence_of :user }
  it { should validate_numericality_of(:list_order).is_greater_than(0).only_integer }
  it { should delegate_method(:category).to(:video) }
  it { should delegate_method(:title).to(:video).with_prefix :video }
  it { should delegate_method(:name).to(:category).with_prefix :category }

  let(:user) { Fabricate(:user) }

  describe '#rating' do
    it "returns the rating from the review when the review is present" do
      video = Fabricate(:video)
      Fabricate(:review, rating: 5, user: user, video: video)
      item = Fabricate(:queue_item, video: video, user: user, list_order: 1 )
      expect(item.rating).to eq(5)
    end

    it "returns nil if no review is presnet" do
      video = Fabricate(:video)
      item = Fabricate(:queue_item, video: video, user: user, list_order: 1 )
      expect(item.rating).to be_nil
    end
  end

  describe '#rating=' do
    let(:video) { Fabricate(:video) }
    
    it "updates a rating if it exists" do
      Fabricate(:review, rating: 5, video: video, user: user)
      Fabricate(:queue_item, video: video, list_order: 1, user: user, rating: 3)
      expect(Review.first.rating).to eq(3)
    end

    it "clears a review if the value passed in is blank" do
      Fabricate(:review, rating: 5, video: video, user: user)
      Fabricate(:queue_item, video: video, list_order: 1, user: user, rating: "")
      expect(Review.first.rating).to be_nil
    end

    it "create a new review with the rating passed in if none exists" do
      Fabricate(:queue_item, video: video, list_order: 1, user: user, rating: 5)
      expect(Review.first.rating).to eq(5)
    end
  end
end
