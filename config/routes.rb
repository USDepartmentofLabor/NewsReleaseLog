Rails.application.routes.draw do
  resources :distributionlists
  resources :regions
  resources :agencies
  resources :news_logs
  devise_for :users
  root to: "news_logs#index"
end
