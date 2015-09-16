class ReviewsController < ApplicationController
  before_action :require_login

  def create
    video = Video.find(params[:video_id])
    @review = Review.new(review_params.merge(video: video, user: current_user))
    unless @review.save
      flash[:danger] = "Please enter content for your review."
    end
    redirect_to video_path(video)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
