class Dashboard::DashboardController < InheritedResources::Base
  respond_to :html, :xml, :json
  before_filter :require_user
  before_filter :check_user_permissions 
  layout 'dashboard'
  
  def welcome
    @user = current_user
  end
  
  protected
    def check_user_permissions
      if params[:user_id]
        if current_user != User.find_by_id(params[:user_id])
          insufficient_permissions
        end
      end
    end
    
    def insufficient_permissions
      flash[:notice] = "You don't have permissions to that page."
      redirect_to dashboard_path
    end

end