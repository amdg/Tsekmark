module ConversationsHelper
  include Haml::Helpers
  include Haml::Util

  def conversation_row(convo)

    str = capture_haml do
      haml_tag :tr do
        haml_tag :td do
          haml_concat image_tag(convo.last_sender.photo(:thumb), class: 'img-circle')
        end
        haml_tag :td do
          if convo.is_unread?(blaster)
            haml_tag :strong do haml_concat convo.last_sender.name end
          else
            haml_concat convo.last_sender.name
          end
        end
        haml_tag :td do
          if convo.is_unread?(blaster)
            haml_tag :strong do haml_concat link_to(convo.subject, convo) end
          else
            haml_concat link_to(convo.subject, convo)
          end
        end
        haml_tag :td do
          if convo.is_unread?(blaster)
            haml_tag :strong do haml_concat time_ago_in_words(convo.updated_at) end
          else
            haml_tag(:abbr, convo.updated_at.to_s, :title => convo.updated_at.getutc.iso8601, class: 'timeago small muted')
          end
        end
      end

    end
    str
  end
end