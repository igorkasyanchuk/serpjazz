class HomeController < ApplicationController
  
  def index
  end
  
  def research
    load_or_create_page("Research")
  end

  def funding
    load_or_create_page("Funding")
  end

  def offerings
    load_or_create_page("Offerings")
  end

  def firms
    load_or_create_page("Firms")
  end

  def resources
    load_or_create_page("Resources")
  end

  def events
    load_or_create_page("Events")
  end

  def media
    load_or_create_page("Media")
  end

  def qa
    load_or_create_page("Q & A")
  end

  def news
    load_or_create_page("News")
  end
  
  def contact
    load_or_create_page("Contact")
  end  

end
