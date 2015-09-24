class QueueItemsController < ApplicationController
  before_action :require_login

  def index
    @items = current_user.queue_items
    unless logged_in?
      redirect_to log_in_path
    end
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video) unless not_in_queue?(video)
    redirect_to my_queue_path
  end

  def destroy
    item = QueueItem.find(params[:id])
    if current_user.queue_items.include? item
      item.destroy
      update_list_orders
    end
    redirect_to my_queue_path
  end

  private

  def update_list_orders
    current_user.queue_items.each_with_index do |item, index|
      item.update_attribute(:list_order, index + 1)
    end
  end

  def queue_video(video)
    QueueItem.create(list_order: get_list_order, video: video, user: current_user)
  end

  def get_list_order
    current_user.queue_items.size + 1
  end

  def not_in_queue?(video)
    current_user.queue_items.map(&:video).include? video
  end
end
