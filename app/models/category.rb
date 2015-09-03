class Category < ActiveRecord::Base
  has_many :videos, -> { order("title") }
  validates :name, presence: true

  #should grab the most recent 6 videos
  def recent_videos
    Video.where(category_id: self.id).order(created_at: :desc).limit(6)
  end
end
