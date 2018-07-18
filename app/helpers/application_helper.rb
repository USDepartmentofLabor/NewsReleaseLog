module ApplicationHelper
  def flash_class(level)
    case level
        when "notice" then "alert alert-info"
        when "success" then "alert alert-success"
        when "error" then "alert alert-danger"
        when "alert" then "alert alert-warning"
    end
  end

  def date_format(date)
    return "" unless date
    date.strftime("%m/%d/%Y")
  end

  # Displays object errors
  def form_errors_for(object=nil)
    render('shared/form_errors', object: object) unless object.blank?
  end
end
