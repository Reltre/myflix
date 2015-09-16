class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(review_params.merge!(user: current_user))
    if review.save
      redirect_to video_path(@video)
    else
      flash.now[:danger] = "Please enter content for your review."
      @reviews = @video.reviews.reload
      render "videos/show"
    end

  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
