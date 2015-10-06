class QueueItemsController < ApplicationController
  before_action :require_login
  before_action :set_items, only: [:index, :update]
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
      update_list_orders
    end
    redirect_to my_queue_path
  end

  def update
    binding.pry
    begin
      QueueItem.transaction do
        QueueItem.all.each_with_index do |item, index|
          item.update!( list_order: params["list_order_#{index}"] )
        end
      end
      @items = @items.reload
      redirect_to my_queue_path
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "One or more of your queue items did not update."
      render :index
    end
  end

  private

  def set_items
    @items = current_user.queue_items
  end

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
end
