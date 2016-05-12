require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_many(:queue_items).order(:list_order) }
  it { is_expected.to have_many(:reviews).order('created_at DESC') }

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
