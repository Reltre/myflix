class Video < ActiveRecord::Base
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
end
