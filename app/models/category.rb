class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at DESC") }
  validates :name, presence: true

  #should grab the most recent 6 videos
  def recent_videos
    videos.limit(6)
  end
end
