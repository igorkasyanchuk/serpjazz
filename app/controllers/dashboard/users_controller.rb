class Dashboard::UsersController < Dashboard::DashboardController
  before_filter :check_user_permissions  do |controller|
    controller.instance_eval do
      insufficient_permissions if current_user.id != resource.id if resource
    end
  end
    
  def show
    redirect_to root_path
  end
  
end