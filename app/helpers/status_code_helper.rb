module StatusCodeHelper
  def handle_500
    handle_error e
  end

  def handle_404(e)
    handle_error e
  end

  def handle_403(e)
    handle_error e
  end

  def handle_401(e)
    handle_error e
  end

  def handle_400(e)
    handle_error e
  end

  def handle_error(e)
    ap e.backtrace
    ap e.message
    flash[:alert] = e.message
    #redirect_to root_path
  end
end