Rails.application.routes.draw do
  get 'newsletter/home'

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }, skip: :registrations

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  namespace :admin do
    resources :games
  end

  root 'newsletter#home'

  resources :games, only: [:index, :show, :new, :create] do
    member do
      get 'upvote'
      get 'unupvote'
    end
    resources :videos, only: [:create]
    resources :comments, only: [:create]
  end

  resources :users do
    get :autocomplete_user_name, :on => :collection
  end

end
