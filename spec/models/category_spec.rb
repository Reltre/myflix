require 'rails_helper'

describe Category, type: :model do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }
end
