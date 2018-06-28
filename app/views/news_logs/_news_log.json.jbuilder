json.extract! news_log, :id, :received_date, :release_date, :title, :user_id, :agency_id, :region_id, :distributionlist_id, :created_at, :updated_at
json.url news_log_url(news_log, format: :json)
