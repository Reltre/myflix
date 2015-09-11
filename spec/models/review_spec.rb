require 'rails_helper'

describe Review do
  it { should belong_to(:video) }
  it "validates presence of rating"
  it "validates presence of description"
  it "validates presence of title"
end
