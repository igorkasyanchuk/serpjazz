module ApplicationHelper

  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << "<div class='#{msg} flash'>#{html_escape(flash[msg.to_sym])}</div>" unless flash[msg.to_sym].blank?
    end
    flash.clear
    messages
  end
  
  def inside_layout(layout = 'application', &block) 
    render :inline => capture_haml(&block), :layout => "layouts/#{layout}" 
  end
  
  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end
  
  def title(t)
    content_for :title do
      t
    end
  end
  
  def get_page_link(page)
    pages =  {
      "Home" => root_path,
      "Research" => research_path,
      "Funding" => funding_path,
      "Offerings" => offerings_path,
      "Firms" => firms_path,
      "Resources" => resources_path,
      "Events" => events_path,
      "Media" => media_path,
      "Q & A" => qa_path,
      "News" => news_path,
      "Contact" => new_contact_path    
    }
    pages[page.name] || root_path
  end
  
  def description(t)
    content_for :description do
      t
    end
  end
  
  def keywords(t)
    content_for :keywords do
      t
    end
  end
  
  def make_page_flyid
    content_for :admin_css_class do
      'admin_css_class'
    end
  end
  
  def disable_social
    content_for :social_footer do "yes" end
  end

  def no_index_me
    content_for :noindex do
      'noindex'
    end
  end
  
  def red_green_icon(b)
    b ? (image_tag 'green.png') : (image_tag 'red.png')
  end
  
  def httpize(url)
    if url !~ /http:\/\//
      'http://' + url
    else
      url
    end
  end
  
  def add_city_name_autocomplete(field)
    content_for :on_ready do
      "$('##{field}').autocomplete({ minLength: 1, source: '/autocomplete_city_name' });"
    end
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, :class => css_class
  end
  
  def w3c_date(date)
    date.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end  

  def add_google_map
    content_for :map do
      '<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>'
    end
  end
  
  def add_google_map_2
    content_for :map do
      "<script src='http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=#{GOOGLE_KEYS[Rails.env.to_s]}' type='text/javascript'></script>".html_safe
    end
  end
  
  def yes_no(b)
    b ? 'yes' : b.nil? ? '' : 'no'
  end
  
  def dashboard?
    controller_name == 'dashboard' && action_name = 'welcome'
  end
  
  def home_page?
    controller_name == 'home' && action_name = 'index'
  end
  
  def bar_page?
    controller_name == 'places' && action_name =~ /show|reviews/
  end
  
  def include_google_analytics
    render :partial => '/shared/ga' if Rails.env == 'production'
  end
  
  def add_admin_nav
    content_for :admin_nav_items do
      (link_to 'Admin Panel', admin_path)
    end if current_user && current_user.is_admin?
  end
  
  def static_rating(value)
    whole = value.to_i
    rest = value - whole
    imgs = ""
    [0,1,2,3,4].each do |i|
      imgs += if whole > i
        "<img src='/images/star-on.png' alt='#{i+1}' title='#{i+1}' />"
      elsif value > i
        "<img src='/images/star-half.png' alt='#{i+1}' title='#{i+1}' />"
      else
        "<img src='/images/star-off.png' alt='#{i+1}' title='#{i+1}' />"
      end
    end
    imgs.html_safe
  end
  
  def admin?
    return false unless logged_in?
    current_user && current_user.is_admin?  
  end
  
  def add_editor
    content_for :css do
      stylesheet_link_tag '/redactor/css/editor.css'
    end
    content_for :js do
      javascript_include_tag '/redactor/editor.js'
    end
  end
  
  def editor(element) 
    content_for :on_ready do 
      "$('#{element}').editor(redactor);".html_safe
    end
  end   
  
end

  def add_google_map_v3
    content_for :js do
      javascript_include_tag "http://maps.google.com/maps/api/js?sensor=false"
    end
  end
  
  def static_map_image(arr)
    "http://maps.google.com/maps/api/staticmap?center=#{arr[0]},#{arr[1]}&zoom=#{arr[2]}&size=300x300&sensor=false".html_safe
  end