class Dashboard::AssetsController < Dashboard::DashboardController
  include ActionView::Helpers::JavaScriptHelper

  protect_from_forgery :except => :create 

  def create 
    file = Asset.new(:file => params[:file]) 
    if file.save 
     render :text => "<a href='#{escape_javascript(file.file.url)}'>#{escape_javascript(file.file_file_name)}</a>"
    end
  end
  
  protected
    def collection
      @assets ||= end_of_association_chain.recent
    end

end