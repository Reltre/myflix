class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?
    Video.where('title ILIKE ?', "%#{title}%").order(created_at: :desc)
  end

  def calculate_rating
    return 0 if reviews.empty?
    reviews.reduce(0) { |sum, review| sum + review.rating } / reviews.size.to_f
  end
end
