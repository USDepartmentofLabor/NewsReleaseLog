Rails.application.routes.draw do
  get '/news_logs/search', to: 'search#search'
  resources :distributionlists
  resources :regions
  resources :agencies
  resources :news_logs  do
    collection do
      get :publised
      get :drafts
      get :active_drafts
    end
  end
  devise_for :users
  root to: "news_logs#index"
  scope module: 'admin' do
    resources :users
  end
end
