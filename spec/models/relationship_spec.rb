require 'rails_helper'

describe Relationship do
  it { is_expected.to belong_to(:leader).class_name('User') }
  it { is_expected.to belong_to(:follower).class_name('User') }
end
