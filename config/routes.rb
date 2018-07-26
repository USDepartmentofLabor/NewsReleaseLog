Rails.application.routes.draw do
  get '/news_logs/search', to: 'search#search'
  get '/search', to: 'search#advanced_search_get'
  post '/search', to: 'search#advanced_search_post'
  resources :distributionlists
  resources :regions
  resources :agencies
  resources :news_logs  do
    collection do
      get :publised
      get :drafts
      get :active_drafts
    end
    member do
      get :get_document
      get :history
    end
  end
  # match '/uploads/grid/news_log/document/:id/:filename' => 'news_logs#get_document', :via => [:get]
  devise_for :users
  root to: "news_logs#index"
  scope module: 'admin' do
    resources :users
  end
end
