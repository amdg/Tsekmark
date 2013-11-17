class LocationsController < ApplicationController

  before_filter :load_location, :only => :show

  def index
    results = Location.search(params[:term]).inject([]) do |locs, loc|
      locs << { value: loc.combined, id: loc.id }
    end
    render json: results
  end

  def show
    @blasts = @location.blasts
    @profile = @location
    render :layout => 'profile'
  end

  def add
    selected_location = params[:selected_location]
    if selected_location
      location = Location.find(selected_location)
      if location && current_user.update_attribute(:location, location)
        flash[:notice] = 'Thank you for adding your city!'
        redirect_to dashboard_index_path and return
      else

        render :add
      end
    end
    render :layout => 'clean'
  end

  private

  def load_location
    @location = Location.find params[:id]
  end
end
