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
      "bg-info"
    when "published"
      "bg-success"
    when "archived"
      "bg-warning"
    else
      "bg-dark"
    end
  end

  def show_news_log_modification(track)
    if track.original.present?
      changes=[]
      track.modified.each do |key,value| 
        changes << content_tag(:p,"Changed: #{key.capitalize} from #{track.original[key.to_sym]} to #{track.modified[key.to_sym]}")
      end
       changes.join.html_safe
    else
      changes=[]
      changes << content_tag(:div,"Created News Release with")
      track.modified.each do |key,value| 
         row = content_tag(:div,class: ["bg-white p-1"]) do 
          content_tag(:span,"#{key.capitalize}:  ") + 
          content_tag(:span, "#{track.modified[key.to_sym].to_s.try(:capitalize)}", class: ["text-dark"] )
         end
         changes << row
      end
       changes.join.html_safe
    end
  end
end
