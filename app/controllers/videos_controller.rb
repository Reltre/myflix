class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    binding.pry
    @video = Video.find(params[:id])
  end
end
