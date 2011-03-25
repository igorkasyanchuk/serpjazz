RailsjazzCom::Application.routes.draw do
  match '/simple_captcha(/:action)' => 'simple_captcha', :as => :simple_captcha 

  resource :user_session do 
    get 'logout'
  end

  resources :password_resets
  resources :users do
    resources :posts, :only => [:index, :show] 
  end

  resources :contacts, :only => [:new, :create, :index]

  namespace :admin do
    match '/', :to => 'dashboard#welcome'
    resources :contacts, :only => [:index, :destroy]
    resources :pages, :except => [:new] do
      resources :page_sections
    end
    resources :users do
      member {  get :toggle_admin  }
    end
  end

  namespace :dashboard do
    match '/', :to => 'dashboard#welcome'
    resources :asset_photos, :except => [:destroy]
    resources :assets, :except => [:destroy]
    resources :users, :only => [:edit, :update, :show] do
      resources :projects
    end
  end

  root :controller => 'home', :action => 'index'
  match "/thisissitmemap.xml", :controller => "sitemap", :action => "sitemap", :format => 'xml' 

  match "/research", :controller => "home", :action => "research"
  match "/funding", :controller => "home", :action => "funding"
  match "/offerings", :controller => "home", :action => "offerings"
  match "/firms", :controller => "home", :action => "firms"
  match "/resources", :controller => "home", :action => "resources"
  match "/events", :controller => "home", :action => "events"
  match "/media", :controller => "home", :action => "media"
  match "/qa", :controller => "home", :action => "qa"
  match "/news", :controller => "home", :action => "news"
  match "/about", :controller => "home", :action => "about"
end