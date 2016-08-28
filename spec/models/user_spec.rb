require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_many(:queue_items).order(:list_order) }
  it { is_expected.to have_many(:reviews).order('created_at DESC') }
  it do
    is_expected.to have_many(:following_relationships)
      .class_name('Relationship').with_foreign_key('follower_id')
  end
  it do
    is_expected.to have_many(:leading_relationships)
      .class_name('Relationship').with_foreign_key('leader_id')
  end

  describe "#follows?" do
    it "returns true if the user has a following relationship with another user." do
      user = Fabricate(:user)
      another_user = Fabricate(:user)
      Fabricate(:relationship, leader: another_user, follower: user)
      expect(user.follows? another_user).to be
    end

    it "returns false if the user does not have a following relationship with another user." do
      user = Fabricate(:user)
      another_user = Fabricate(:user)
      expect(user.follows? another_user).to_not be
    end
  end

  describe '#can_follow?' do
    it "returns false if the current user is equal to the user" do
      current_user = Fabricate(:user)
      expect(current_user.can_follow? current_user).to_not be
    end

    it "returns false if the current user already follows user" do
      user = Fabricate(:user)
      current_user = Fabricate(:user)
      Relationship.create(leader: user, follower: current_user)
      expect(current_user.can_follow? user).to_not be
    end

    it "return true if the current user is not equal to the user" do
      user = Fabricate(:user)
      current_user = Fabricate(:user)
      expect(current_user.can_follow? user).to be
    end

    it "returns true if the current user does not already follows user" do
      user = Fabricate(:user)
      current_user = Fabricate(:user)
      expect(current_user.can_follow? user).to be
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
