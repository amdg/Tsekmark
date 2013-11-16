module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago small muted"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end

  def viewer_is_same_user?(viewed_user)
    return false unless user_signed_in?
    current_user == viewed_user
  end

  def viewer_is_biz_owner?(viewed_biz)
    return false unless user_signed_in?
    current_user == viewed_biz.user
  end

  def current_url
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

  def followers_text
    biz_context? ? 'Patrons' : 'Followers'
  end
end
