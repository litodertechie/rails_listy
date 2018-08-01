Rails.application.routes.draw do
  get 'users/follow'
  get 'users/unfollow'
  get 'users_controller/follow'
  get 'users_controller/unfollow'
  devise_for :users
  root to: 'pages#home'
  resources :profiles, only: [:show, :index] do
    collection do
      get :autocomplete
    end
  end
  resources :lists
  resources :users do
    member do
      get :follow
      get :unfollow
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
