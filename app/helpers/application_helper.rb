module ApplicationHelper

  def icon(icon)
    render 'ui/icon', icon: icon
  end

  def format_date(date)
    "#{date.strftime("%B")} #{date.day.ordinalize}"
  end

end
