class ContactsController < InheritedResources::Base
  before_filter :store_location
  
  def index
    redirect_to new_contact_path
  end
  
  def create
    @contact = Contact.new(params[:contact])
    captcha_valid = simple_captcha_valid?
    if captcha_valid && @contact.save
      redirect_to root_path, :notice => "You message sent successfully."
    else
      @contact.valid?
      @contact.errors.add_to_base('Code from mage not valid. Try again.') unless captcha_valid
      flash[:error]  = "Please try again."
      render :new
    end
  end
  
end
