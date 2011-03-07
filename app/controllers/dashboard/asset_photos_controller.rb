class Dashboard::AssetPhotosController < Dashboard::DashboardController
  protect_from_forgery :except => :create 

  def create 
    photo = AssetPhoto.new(:photo => params[:file]) 
    if photo.save 
     render :text => photo.photo.url 
    end
  end
  
  protected
    def collection
      @asset_photos ||= end_of_association_chain.recent
    end

end