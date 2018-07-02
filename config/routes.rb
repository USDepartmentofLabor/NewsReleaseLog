Rails.application.routes.draw do
  resources :distributionlists
  resources :regions
  resources :agencies
  resources :news_logs  do
    collection do
      get :publised
      get :drafts
      get :active_drafts
      get :search
    end
  end
  devise_for :users
  root to: "news_logs#index"
end
