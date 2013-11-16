class ApplicationController < ActionController::Base
  protect_from_forgery

  include StatusCodeHelper

  rescue_from(Exception) do |e|
    case e
      when ActiveRecord::RecordNotFound,
          ActionController::RoutingError
        handle_404(e)
      when CanCan::AccessDenied
        handle_403(e)
      when ArgumentError,
          ActionView::MissingTemplate,
          JSON::ParserError
        handle_400(e)
      else
        raise e
    end
  end

  before_filter :initialize_flashes
  before_filter :redirect_to_add_location

  helper_method :controller_namespace, :namespaced_controller_name, :user_context?,
                :biz_context?, :context, :edit_blaster_path, :blaster

  def initialize_flashes
    flash[:alert] ||= []
    flash[:notice] ||= []
    flash[:success] ||= []
  end

  def controller_namespace
    self.class.controller_namespace
  end

  def namespaced_controller_name
    self.class.namespaced_controller_name
  end

  def self.controller_namespace
    @controller_namespace ||= controller_name == namespaced_controller_name ? nil : namespaced_controller_name.sub(/\.#{controller_name}$/, '')
  end

  def self.namespaced_controller_name
    @namespaced_controller_name ||= name.sub(/Controller$/, '').underscore.gsub(/\//, '.')
  end

  def namespaced_controller_action
    "#{namespaced_controller_name}.#{params[:action].to_s}"
  end

  def load_user
    @user = User.find params[:user_id] || params[:id]
  end

  def context
    cookies[:context]
  end

  def set_context(new_context)
    cookies.delete(:context) if cookies[:context]
    cookies[:context] = new_context
  end

  def switch_context!
    new_context = user_context? ? 'biz' : 'user'
    set_context(new_context) if current_user.has_business?
  end

  def default_context
    #current_user.has_business? ? 'biz' : 'user'
    'user'
  end

  def biz_context?
    context == 'biz'
  end

  def user_context?
    context == 'user'
  end

  def blaster
    biz_context? ? current_user.business : current_user
  end

  def edit_blaster_path
    biz_context? ? business_edit_path : edit_user_registration_path
  end

  def redirect_to_add_location
    redirect_to locations_add_path and return if user_signed_in? && current_user.location.blank?
  end
end
