class VideosController < ApplicationController
  before_action :require_login
  before_action :set_video, only: [:show, :add_review]

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title params[:q]
  end

  def add_review
    @review = Review.new( rating: params[:rating],
                          description: params[:description],
                          video: @video,
                          user: current_user)
    @review.save!
    redirect_to video_path(@video)
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end
