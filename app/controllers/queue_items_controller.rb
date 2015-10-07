class QueueItemsController < ApplicationController
  before_action :require_login
  before_action :set_items, only: [:index, :update_queue]
  helper_method :list_orders

  def index
    # @items = set_items
    unless logged_in?
      redirect_to log_in_path
    end
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video) unless current_user.has_already_queued?(video)
    redirect_to my_queue_path
  end

  def destroy
    item = QueueItem.find(params[:id])
    if current_user.queue_items.include? item
      item.destroy
      normalize_list_orders
    end
    redirect_to my_queue_path
  end

  def update_queue
    begin
      update_queue_items
      normalize_list_orders
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "One or more of your queue items did not update."
    end

    redirect_to my_queue_path
  end

  private

  def update_queue_items
    QueueItem.transaction do
      current_user.queue_items.each_with_index do |item, index|
        item.update_attributes!( list_order: params[:list_orders][index] )
      end
    end
  end

  def set_items
    @items = current_user.queue_items
  end

  def normalize_list_orders
    current_user.queue_items.reload.each_with_index do |item, index|
      item.update_attribute(:list_order, index + 1)
    end
  end

  def queue_video(video)
    QueueItem.create(list_order: get_list_order, video: video, user: current_user)
  end

  def get_list_order
    current_user.queue_items.size + 1
  end
end
