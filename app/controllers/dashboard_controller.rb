class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    ap context
    @blasts = Blast.from_followings_and_location(
        current_user.user_ids_that_matter,
        current_user.biz_ids_that_matter,
        current_user.location_id)
  end

  def switch
    switch_context!
    redirect_to params[:redirect_path] || root_path
  end
end
