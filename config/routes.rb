Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }, skip: :registrations

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :admin do
    resources :games
  end

  # You can have the root of your site routed with "root"
  root 'games#index'

  resources :games, only: [:index, :show, :new, :create] do
    member do
      post 'upvote'
      post 'unupvote'
    end
    resources :videos, only: [:create]
    resources :comments, only: [:create]
  end

end
