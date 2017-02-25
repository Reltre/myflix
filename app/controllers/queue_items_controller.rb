class QueueItemsController < AuthenticatedController
  before_action :set_items, only: [:index, :update_queue, :destroy]

  def index
    unless logged_in?
      redirect_to log_in_path
    end
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video) unless current_user.has_already_queued?(video)
    redirect_to queue_items_path
  end

  def destroy
    item = QueueItem.find(params[:id])
    if @items.include? item
      item.destroy
      current_user.normalize_list_order_of_queue_items
    end
    redirect_to queue_items_path
  end

  def update_queue
    begin
      update_queue_items
      current_user.normalize_list_order_of_queue_items
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "One or more of your queue items did not update."
    end

    redirect_to queue_items_path
  end

  private

  def update_queue_items
    list_orders = params[:queue_items_data][:list_orders]
    ratings = params[:queue_items_data][:ratings]
    QueueItem.transaction do
      @items.each_with_index do |item, index|
        item.update!( list_order: list_orders[index], rating: ratings[index] )
      end
    end
  end

  def set_items
    @items = current_user.queue_items
  end

  def queue_video(video)
    QueueItem.create(list_order: get_list_order, video: video, user: current_user)
  end

  def get_list_order
    current_user.queue_items.size + 1
  end
end
