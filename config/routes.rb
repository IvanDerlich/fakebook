Rails.application.routes.draw do
  authenticated :user do
    root 'posts#index', as: :authenticated_user
  end

  devise_for :users, skip: [:sessions]
  
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy'
    root 'devise/sessions#new'
  end
  
  get 'dashboard', to: 'users#show'

  resources :posts do
    resources :comments, skip: [:index, :new]
    resources :likes, only: [:new]
  end
  
  resources :friendships, only: [:new]
  put 'friendships/confirms_friend/:friend_id', to: 'friendships#update', as: :friendship_confirm

  get 'users', to: 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'posts#index'
end
