module ApplicationHelper

  def format_date(date)
    # params[:view] == "daily" ? "#{date.strftime("%B")}#{date.day.ordinalize}" : "#{date.strftime("%B")} #{date.day.ordinalize}"
    "#{date.strftime("%B")} #{date.day.ordinalize}"
  end

end
