class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers 

  protect_from_forgery

  helper_method :current_user_session, :current_user, :logged_in?, :require_admin_user, :is_mobile?
  
  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                        'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                        'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                        'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                        'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' +
                        'mobile'
  MOBILE_BROWSERS = [
    "iphone", "android", "ipod", "opera mini", "blackberry", 
    "palm", "hiptop", "avantgo", "plucker", "xiino", "blazer", "elaine", "windows ce; ppc;", 
    "windows ce; smartphone;", "windows ce; iemobile", "up.browser", "up.link", "mmp", "symbian",
    "smartphone", "midp", "wap", "vodafone", "o2", "pocket", "kindle", "mobile", "pda", "psp", "treo"
  ] << MOBILE_USER_AGENTS

  MOBILE_BROWSERS_REGEXP = Regexp.new(MOBILE_BROWSERS.join('|'))
  
  # before_filter :log_device

  protected
    def is_mobile?
      agent = request.headers["HTTP_USER_AGENT"].to_s.downcase
      (agent =~ MOBILE_BROWSERS_REGEXP)
    end

    def log_device
      logger.info "device mobile => #{is_mobile?}".red
    end   

  private

    def logged_in?
      !!current_user
    end
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end
    
    def load_or_create_page(page)
      @page = Page.find_or_create_by_name(page)
    end    
    
    def require_admin_user
      unless current_user && current_user.is_admin?
        flash[:notice] = "You don't have permissions to access this page"
        redirect_to dashboard_path
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to dashboard_path
        return false
      end
    end    
    
    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end
