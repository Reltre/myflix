class VideosController < AuthenticatedController
  def index
    @categories = Category.all
  end

  def show
    @video = Video.find_by(url_digest: params[:id])
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title params[:q]
  end

  def play
    @video = Video.find_by(url_digest: params[:id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
