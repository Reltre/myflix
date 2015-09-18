require 'rails_helper.rb'

describe MyQueue do
  it { should belong_to :video }
  it { should belong_to :user }
  it { validate_presence_of :video }
  it { validate_presence_of :user }
end
