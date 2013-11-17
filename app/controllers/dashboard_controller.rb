class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @blasts = []
  end
end
