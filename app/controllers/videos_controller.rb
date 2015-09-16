class VideosController < ApplicationController
  before_action :require_login
  before_action :set_video, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title params[:q]
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end
