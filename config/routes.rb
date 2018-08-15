Rails.application.routes.draw do
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
    end
  end
  resources :activities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
