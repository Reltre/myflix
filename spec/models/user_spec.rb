require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_many(:queue_items).order(:list_order) }
  it { is_expected.to have_many(:reviews).order('created_at DESC') }
  it do
    is_expected.to have_many(:follows)
      .class_name('User').with_foreign_key('follower_id')
  end
  it do
    is_expected.to belong_to(:follower)
      .class_name('User')
  end

  describe '#followers' do
    it "returns 0 if a user has no followers" do
      user = Fabricate(:user)
      expect(user.followers.count).to eq(0)
    end

    it "returns the correct number of followers" do
      joe = Fabricate(:user)
      elaine = Fabricate(:user)
      sally = Fabricate(:user, full_name: "Sally Andal", follower_id: joe.id)
      Fabricate(:user,full_name: "Sally Andal", follower_id: elaine.id )
      expect(sally.followers.count).to eq(2)
    end
  end

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
