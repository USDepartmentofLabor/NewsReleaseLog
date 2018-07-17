module NewsLogsHelper
  def grid_fs_filename(news_log)
    return nil unless news_log.document.present?
    news_log.document.try(:file).path.split("/").last rescue "Attached File"
  end
end
