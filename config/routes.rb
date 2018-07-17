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
    member do
      get :get_document
    end
  end
  # match '/uploads/grid/news_log/document/:id/:filename' => 'news_logs#get_document', :via => [:get]
  devise_for :users
  root to: "news_logs#index"
  scope module: 'admin' do
    resources :users
  end
end
