class HomeController < ApplicationController
  before_filter :redirect_logged_in_users
  def index
    render :layout => 'home'
  end

  def redirect_logged_in_users
    redirect_to dashboard_index_path and return if user_signed_in?
  end
end
