module NewsLogsHelper
  def grid_fs_filename(news_log)
    return nil unless news_log.document.present?
    news_log.document.try(:file).path.split("/").last rescue "Attached File"
  end
  def status_color(news_log)
    case news_log.aasm_state
    when "draft"
      "bg-dark"
    when "review"
      "bg-info"
    when "published"
      "bg-success"
    when "archived"
      "bg-warning"
    else
      "bg-dark"
    end
  end
end
