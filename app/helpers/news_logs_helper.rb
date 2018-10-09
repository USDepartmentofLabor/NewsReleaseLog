module NewsLogsHelper
  def news_log_buttons(f,news_log)
    if news_log.draft? && f.object.persisted?
      render partial: "draft_buttons", locals: { f: f }
    elsif news_log.review?
      render partial: "review_buttons", locals: { f: f }
    elsif news_log.published?
      render partial: "publish_buttons", locals: { f: f }
    else
      render partial: "new_buttons", locals: { f: f }
    end
  end

  def grid_fs_filename(news_log)
   return nil unless news_log.document.present?
   news_log.document.try(:file).path.split("/").last rescue "Attached File"
  end

  def status_color(news_log)
    case news_log.aasm_state
    when "draft"
      "bg-dark"
    when "review"
      'review-status-bg'
    when "published"
      'published-status-bg'
    when "archived"
      'archive-status-bg'
    else
      "bg-dark"
    end
  end
end
