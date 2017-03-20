require 'rails_helper'
require 'carrierwave/test/matchers'

describe LargeCoverUploader do
  include CarrierWave::Test::Matchers

  let(:video) { Fabricate(:video) }
  let(:uploader) { LargeCoverUploader.new(video, :large_cover) }

  before do
    LargeCoverUploader.enable_processing = true
    File.open("#{Rails.root}/public/tmp/test_large.jpg") { |f| uploader.store!(f) }
  end

  after do
    LargeCoverUploader.enable_processing = false
    uploader.remove!
  end

  context "large cover" do
    it "scales images to 665 by 375" do
      expect(uploader).to have_dimensions(665, 375)
    end
  end
end
