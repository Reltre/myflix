Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end

  resources :categories, only: [:create, :show]
  resources :users, only: [:create]

  get '/log_in', to: 'sessions#new'
  post '/log_in', to: 'sessions#create'
  post '/sign_out', to: 'sessions#destroy'
  get '/register', to: 'users#new'

  root 'pages#front'
end
