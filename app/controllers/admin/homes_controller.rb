class Admin::HomesController < AdminsController
  before_action :require_login, :ensure_admin

  def index
    @categories = Category.all
  end
end
