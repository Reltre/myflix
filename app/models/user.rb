class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :reviews
  has_many :queue_items, -> { order("list_order ASC") }

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email


  def has_already_queued?(video)
    queue_items.map(&:video).include? video
  end
end
