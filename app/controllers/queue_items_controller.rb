class QueueItemsController < ApplicationController
  before_action :require_login

  def index
    @items = current_user.queue_items
    unless logged_in?
      redirect_to log_in_path
    end
  end

  def create
    video_id = params[:video_id]
    position = current_user.queue_items.size + 1
    item = current_user.queue_items.new(list_order: position, video_id: video_id)
    if not_in_queue? && item.save
      flash[:info] = "This video has been added to your queue"
    end

    redirect_to my_queue_path
  end
end

private

def not_in_queue?
  current_user.queue_items.count(video_id: params[:video_id]).zero?
end
