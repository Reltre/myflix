class AdminsController < AuthenticatedController
  before_action :ensure_admin

  def ensure_admin
    if !current_user.admin?
      flash[:danger] = "You do not have access to that area."
      redirect_to home_path
    end
  end
end
