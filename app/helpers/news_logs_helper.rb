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
end
