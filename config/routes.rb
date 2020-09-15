Rails.application.routes.draw do
  get 'participations/index'
  get 'participations/new'
  get 'participations/create'
  get 'participations/destroy'
  mount ActionCable.server => '/cable'

  root 'rooms#index'

  resources :messages, only: [:create, :edit, :update, :destroy]
  resources :users

  resources :rooms, except: [:index], shallow: true do
    resources :participations, only: [:index, :create, :destroy]
  end
  get 'msg_destroy_confirm', to: 'messages#destroy_confirm'
  get 'deletemessage/:id', to: 'messages#destroy'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
