class SessionsController < Devise::SessionsController

  def create
    #set_context(default_context)
    super
  end

  def destroy
    cookies.delete(:context)
    super
  end

  def after_sign_in_path_for
    dashboard_path
  end

end