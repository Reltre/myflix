class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order(:list_order) }

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email


  def has_already_queued?(video)
    queue_items.map(&:video).include? video
  end

  def normalize_list_order_of_queue_items
    queue_items.reload.each_with_index do |item, index|
      item.update_attribute(:list_order, index + 1)
    end
  end
end
