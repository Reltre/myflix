class User < ActiveRecord::Base
  include Tokenable

  has_secure_password validations: false
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order(:list_order) }
  has_many :following_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :leading_relationships, class_name: 'Relationship', foreign_key: :leader_id

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  def can_follow?(another_user)
    self != another_user && !follows?(another_user)
  end

  def follows?(another_user)
    !following_relationships.find_by(leader: another_user).nil?
  end

  def has_already_queued?(video)
    queue_items.map(&:video).include? video
  end

  def normalize_list_order_of_queue_items
    queue_items.reload.each_with_index do |item, index|
      item.update_attribute(:list_order, index + 1)
    end
  end
end
