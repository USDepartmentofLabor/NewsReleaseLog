Rails.application.routes.draw do
  get '/news_logs/search', to: 'search#search'
  get '/advsearch', to: 'search#advanced_search'
  post '/advsearch', to: 'search#advanced_search'
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
    get 'users/:id/password' => 'users#edit_password', as: 'admin_edit_user_password'
    patch 'users/:id/user_password_update' => 'users#update_password', as: 'admin_update_user_password'
  end
end
