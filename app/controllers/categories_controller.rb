class CategoriesController < AuthenticatedController
  def create; end

  def show
    @category = Category.find(params[:id])
  end
end
