class Review < ActiveRecord::Base
  belongs_to :video
  validates_presence_of :rating, :description

  def self.calculate_rating
    0
  end
end
