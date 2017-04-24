Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'subs#index'

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :subs do
    resources :posts, only: [:create, :new] do
      resources :comments, only: [:new]
    end
  end
  resources :comments, except: [:new]
  resources :posts, except: [:create, :index, :new]
end
