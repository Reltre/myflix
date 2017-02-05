require 'rails_helper'

describe Invitation do
  it { is_expected.to belong_to :inviter }
  it { is_expected.to belong_to :invitee }
  it { is_expected.to validate_presence_of :email }
end
