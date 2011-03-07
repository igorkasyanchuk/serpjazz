class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(dashboard_path)
    else
      render :action => :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
end
