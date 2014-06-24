Rails.application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'homepage'
  get '/about' => 'high_voltage/pages#show', id: 'about'

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :activities

end