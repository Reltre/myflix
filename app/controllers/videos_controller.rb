class VideosController < ApplicationController
  before_action :require_login

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
    @review = Review.new( rating: params[:rating],description: params[:description] )
    @review.save!
    render :show
  end
end
