class SmallCoverUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.test? || Rails.env.development?
    storage :file
  elsif Rails.env.staging? || Rails.env.production?
    storage :aws
  end
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  process resize_to_fit: [166, 236]

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
