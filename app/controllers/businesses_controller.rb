class BusinessesController < ApplicationController

  before_filter :load_biz, :only => [:show, :destroy, :edit]

  def new
  end

  def update
    @biz = current_user.business
    biz_params = params[:business]
    biz_params[:location] = Location.find params[:selected_location]
    biz_params[:business_category] = BusinessCategory.find params[:selected_category]
    if @biz.update_attributes!(biz_params)
      flash[:notice] = 'Business details updated!'
    else
      flash[:alert] = 'Business details cannot be updated'
    end
    redirect_to business_edit_path
  end

  def edit
    render :layout => 'layouts/clean'
  end

  def show
    @user = @biz.user
    render :layout => 'layouts/profile'
  end

  def create
    biz_params = params[:business]
    biz_params.delete(:location)
    biz_params.delete(:business_category)
    location = Location.find params[:selected_location]
    category = BusinessCategory.find params[:selected_category]
    biz = Business.new(biz_params)
    biz.location = location
    biz.user = current_user
    biz.business_category = category
    if biz.save!
      redirect_to business_path biz
    else
      render :new
    end
  end

  def load_biz
    @biz = Business.find_by_id params[:id]
    redirect_to new_business_path unless @biz
  end
end
