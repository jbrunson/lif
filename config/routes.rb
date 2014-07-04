Rails.application.routes.draw do
  get 'profiles/:id', to: 'profiles#show'

  get "/pages/*id" => 'pages#show', as: :page, format: false

  # match "/about" => 'pages#show', id: 'about', via[:get]

  root to: 'pages#show', id: 'homepage'

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :matches do
    resources :messages
  end
  
  resources :activities
  resources :users do
    resources :likes
    resources :matches
    get 'profile', to: :show
  end

  resources :profiles, only: [:show]




end


