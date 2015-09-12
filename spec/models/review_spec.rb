require 'rails_helper'

describe Review do
  it { should belong_to(:video) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:description) }
end
