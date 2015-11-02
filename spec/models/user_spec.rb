require 'rails_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:list_order) }

  describe '#has_already_queued' do
    it "returns true if the video is in the queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.has_already_queued?(video)).to be
    end

    it "returns false if the video is not in the queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.has_already_queued?(video)).to_not be
    end
  end
end
