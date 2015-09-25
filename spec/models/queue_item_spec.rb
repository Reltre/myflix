require 'rails_helper.rb'

describe QueueItem do
  it { should belong_to :video }
  it { should belong_to :user }

  it { should validate_presence_of :video }
  it { should validate_presence_of :user }

  it { should delegate_method(:category).to(:video) }
  it { should delegate_method(:title).to(:video).with_prefix :video }
  it { should delegate_method(:name).to(:category).with_prefix :category }

  let(:user) { Fabricate(:user) }
  
  describe '#rating' do
    it "returns the rating from the review when the review is present" do
      video = Fabricate(:video)
      Fabricate(:review, rating: 5, user: user, video: video)
      item = Fabricate(:queue_item, video: video, user: user)
      expect(item.rating).to eq(5)
    end

    it "returns nil if no review is presnet" do
      video = Fabricate(:video)
      item = Fabricate(:queue_item, video: video, user: user)
      expect(item.rating).to be_nil
    end
  end
end
