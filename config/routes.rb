Rails.application.routes.draw do
  get 'search/search'
  mount ActionCable.server => '/cable'

  root 'rooms#index'

  resources :messages, only: [:create, :edit, :update, :destroy]
  resources :users

  resources :rooms, except: [:index], shallow: true do
    member do
      get 'join_confirm', to: 'rooms#join_confirm'
    end

    resources :participations, only: [:index, :create, :destroy]
    
  end

  get 'search', to: 'search#search'
  get 'room_search', to: 'search#room_search'
  get 'user_search', to: 'search#user_search'

  get 'create_index', to: 'rooms#create_index'
  get 'participating_index', to: 'rooms#participating_index'
  get 'msg_destroy_confirm', to: 'messages#destroy_confirm'
  get 'deletemessage/:id', to: 'messages#destroy'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
