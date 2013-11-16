class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @blasts = []
  end

  def switch
    switch_context!
    redirect_to params[:redirect_path] || root_path
  end
end
