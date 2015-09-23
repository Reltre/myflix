class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates_presence_of :video, :user

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  def rating
    review = Review.find_by(video: video, user: user)
    review.rating unless review.blank?
  end

  def category_name
    category.name
  end
end
