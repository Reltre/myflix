Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'
  resources :videos, only: [:show]
  resources :categories, only: [:create, :show]
  root 'videos#index'
end
