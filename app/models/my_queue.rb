class MyQueue < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_presence_of :video, :user
end
