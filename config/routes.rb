Rails.application.routes.draw do
  get 'profiles/:id', to: 'profiles#show'

  root to: 'high_voltage/pages#show', id: 'homepage'
  get '/about' => 'high_voltage/pages#show', id: 'about'

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
