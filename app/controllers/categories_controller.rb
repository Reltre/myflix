class CategoriesController < ApplicationController
  def create
  end

  def show
    @category = Category.find(params[:id])
  end
end
