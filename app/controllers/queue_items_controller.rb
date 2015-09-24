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
    unless not_in_queue?(video)
      queue_video(video)
      flash[:info] = "This video has been added to your queue"
    end
    redirect_to my_queue_path
  end

  def destroy
    QueueItem.destroy(params[:queue_id]) if params[:queue_id]
    update_positions
    redirect_to my_queue_path
  end

  private

  def update_positions
    current_user.queue_items.each_with_index do |item, index|
      item.update_attribute(:list_order, index + 1)
    end
  end

  def queue_video(video)
    QueueItem.create(list_order: get_position, video: video, user: current_user)
  end

  def get_position
    current_user.queue_items.size + 1
  end

  def not_in_queue?(video)
    current_user.queue_items.map(&:video).include? video
  end
end
