require 'rails_helper.rb'

describe MyQueue do
  it { should belong_to :video }
  it { should belong_to :user }
  it { should validate_presence_of :video }
  it { should validate_presence_of :user }
end
