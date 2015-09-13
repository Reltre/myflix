Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end

    member do
      post 'add_review', to: 'videos#add_review'
    end
  end

  resources :categories, only: [:create, :show]
  resources :users, only: [:create]

  get '/log_in', to: 'sessions#new'
  get '/log_out', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  post '/log_in', to: 'sessions#create'
  root 'pages#front'
end
