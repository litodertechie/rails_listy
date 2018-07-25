Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :profiles, only: [:show, :index] do
    collection do
      get :autocomplete
    end
  end
  resources :lists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
