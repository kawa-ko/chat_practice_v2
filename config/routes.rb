Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'rooms#index'

  resources :messages, only: [:create, :edit, :update, :destroy]
  resources :users

  resources :rooms, except: [:index]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
