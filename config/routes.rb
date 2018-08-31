Rails.application.routes.draw do
  get 'notifications/index'
  get 'notifications_controller/index'
  get 'activities/index'
  get 'users/follow'
  get 'users/unfollow'
  get 'users_controller/follow'
  get 'users_controller/unfollow'
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'pages#home'
  resources :profiles, only: [:show, :index] do
    collection do
      get :autocomplete
      get :settings
    end
  end
  resources :lists do
    member do
      put "like" => "lists#vote"
    end
  end
  resources :users do
    member do
      get :follow
      get :unfollow
      get :follow_suggestions
      put "settings" => "users#settings"
    end
  end
  resources :activities
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
