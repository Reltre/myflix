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
  resources :sessions, only: [:create]
  get '/login', to: 'sessionss#new'
  get '/register', to: 'users#new'

  root 'sessions#front'
end
