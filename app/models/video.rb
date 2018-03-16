require 'carrierwave/orm/activerecord'

class Video < ActiveRecord::Base
  before_create :generate_url_hash

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  belongs_to :category
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items
  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?
    Video.where('title ILIKE ?', "%#{title}%").order(created_at: :desc)
  end

  def calculate_rating
    return 0.0 if reviews.empty?
    rating =
      reviews.reduce(0) do |sum, review|
        sum + review.rating
      end
    ( rating / reviews.size.to_f ).round(1)
  end

  def to_param
    self.url_digest
  end

  private

  def generate_url_hash
    self.url_digest = SecureRandom.urlsafe_base64(10)
  end
end
