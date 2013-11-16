module APIHelpers

  def warden
    env['warden']
  end

  def authenticated
    if warden.authenticated?
      return true
    elsif params[:auth_token] and
      user = User.find_for_token_authentication(:auth_token => params[:auth_token])
      access_denied! unless user
      access_denied! unless user.confirmed?
      return true
    else
      access_denied!
    end
  end

  def current_user
    warden.user || User.find_for_token_authentication(:auth_token => params[:auth_token])
  end

  def is_admin?
    current_user && current_user.is_admin?
  end

  # returns 401 if there's no current user
  def authenticated_user
    authenticated
    access_denied! unless current_user
  end

  # returns 401 if not authenticated as admin
  def authenticated_admin
    authenticated
    access_denied! unless is_admin?
  end

  def access_denied!(message='')
    error! "Access Denied. #{message} ", 401
  end

  def bad_request!(message='')
    error! "Bad Request. #{message} ", 400
  end

  def forbidden_request!(message='')
    error! "Forbidden. #{message} ", 403
  end

  def not_found!(message='')
    error! "Not Found. #{message} ", 404
  end

  def invalid_request!(message)
    error! message, 422
  end

  def invalid_login_attempt(message='')
    access_denied!(message)
  end


  def logger
    API.logger
  end

end