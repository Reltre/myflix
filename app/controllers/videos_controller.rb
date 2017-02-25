class VideosController < AuthenticatedController
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
end
