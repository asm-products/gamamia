module ApplicationHelper

  def format_date(date)
    "#{date.strftime("%B")} #{date.day.ordinalize}"
  end

end
