class Admin::VideosController < AdminsController
  def create
    video = Video.new(admin_video_params)
    if video.save!
      flash[:success] = "Your video, #{video.title} was created."
      redirect_to admin_homes_path
    else
      @categories = Category.all
      flash[:danger] = "There was a problem creating your video."
      render "admin/homes/index"
    end
  end

  private

  def admin_video_params
    params.require(:video)
          .permit(:title,
                  :category_id,
                  :description,
                  :large_cover,
                  :small_cover)
  end
end
