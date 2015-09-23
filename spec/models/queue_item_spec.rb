require 'rails_helper.rb'

describe QueueItem do
  it { should belong_to :video }
  it { should belong_to :user }
  it { should validate_presence_of :video }
  it { should validate_presence_of :user }

  let(:user) { Fabricate(:user) }

  describe '#video_title' do
    it "returns the video associated with this queue item" do
      video = Fabricate(:video, title: 'Futurama')
      item = Fabricate(:queue_item, video: video, user: user)
      expect(item.video_title).to eq('Futurama')
    end
  end

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

  describe '#category_name' do
    it "returns the category name for this queue item" do
      category = Fabricate(:category, name: 'TV Shows')
      video = Fabricate(:video,category: category)
      item = Fabricate(:queue_item, video: video, user: user)
      expect(item.category_name).to eq('TV Shows')
    end
  end

  describe '#category' do
    it 'returns the category for this queue item' do
      category = Fabricate(:category, name: 'TV Shows')
      video = Fabricate(:video,category: category)
      item = Fabricate(:queue_item, video: video, user: user)
      expect(item.category).to be(category)
    end
  end
end
