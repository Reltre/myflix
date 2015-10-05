class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates_presence_of :video, :user
  validates_numericality_of :list_order, greater_than: 0

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video
  delegate :name, to: :category, prefix: :category

  def rating
    review = Review.find_by(video: video, user: user)
    review.rating unless review.blank?
  end
end
