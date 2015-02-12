module ApplicationHelper

  def avatar(attrs)
    render partial: 'avatars/avatar',
            locals: { user: attrs.fetch(:user), size: attrs[:size] }
  end

  def icon(icon)
    render 'ui/icon', icon: icon
  end

  def format_date(date)
    "#{date.strftime("%B")} #{date.day.ordinalize}"
  end

end
