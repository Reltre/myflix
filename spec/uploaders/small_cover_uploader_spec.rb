require 'rails_helper'
require 'carrierwave/test/matchers'

describe SmallCoverUploader do
  include CarrierWave::Test::Matchers

  let(:video) { Fabricate(:video) }
  let(:uploader) { SmallCoverUploader.new(video, :small_cover) }

  before do
    SmallCoverUploader.enable_processing = true
    File.open("#{Rails.root}/public/tmp/test_small.jpg") { |f| uploader.store!(f) }
  end

  after do
    SmallCoverUploader.enable_processing = false
    uploader.remove!
  end

  context "small cover" do
    it "scales images to 166 by 236" do
      expect(uploader).to have_dimensions(166, 236)
    end
  end
end
