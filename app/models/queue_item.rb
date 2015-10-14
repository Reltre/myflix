class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates_presence_of :video, :user
  validates_numericality_of :list_order, greater_than: 0, only_integer: true

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video
  delegate :name, to: :category, prefix: :category

  def rating
    review.rating unless review.blank?
  end

  def rating=(value)
    if review
      review.update_attribute(:rating, value)
    else
      review = Review.new(video: video, user: user, rating: value)
      review.save validate: false
    end
  end

  private

  def review
    @review ||= Review.find_by(video: video, user: user)
  end
end
