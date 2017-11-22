Myflix::Application.routes.draw do

  root 'pages#front'
  Dir.new('app/views/ui').each do |action|
    next if %w(. ..).include? action
    action = action[/\w+(?=\.html\.haml)/]
    get "ui/#{action}", action: action.to_sym, controller: 'ui'
  end

  get 'home', to: 'videos#index'


  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end

    member do
      get 'play', to: 'videos#play'
    end
    resources :reviews, only: [:create]
  end


  namespace :admin do
    resources :videos, only: [:create]
    resources :homes, only: [:index]
  end

  resources :categories, only: [:create, :show]
  resources :users, only: [:create, :show]
  resources :charges, only: [:new, :create]

  post 'update_queue', to: 'queue_items#update_queue'
  resources :queue_items, only: [:index, :create, :destroy]

  resources :relationships, only: [:create , :destroy]
  get 'people', to: 'relationships#index', as: 'people'

  get 'log_in', to: 'sessions#new'
  get 'log_out', to: 'sessions#destroy'
  get 'register', to: 'users#new'
  post 'log_in', to: 'sessions#create'


  get '/forgot_password', to: 'passwords#forgot'
  get '/confirm_password_reset', to: 'passwords#confirm_reset'
  get '/password_reset/:token', to: 'passwords#show_reset', as: 'password_reset'
  get '/expired_token', to: 'passwords#expired_token'
  post '/password_reset_email', to: 'passwords#email'
  post '/update_password', to: 'passwords#update', as: 'update_password'

  resources :invitations, only: [:new, :create]
end
