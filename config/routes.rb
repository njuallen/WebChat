Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    collection do
      get :index_json
    end
  end

  resources :messages do
    collection do
      delete :destroyall
    end
  end

  resources :chats do
    member do
      patch :trans_auth
      post :add_user
      delete :delete_user
    end
  end

  resources :friendships

  root 'homes#home'

  get 'sessions/new' => 'sessions#new'
  post 'sessions/create' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'

  get 'users/new' => 'users#new'
  post 'users/create' => 'users#create'
  get 'users/:id' => 'users#show'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'
  get 'users/:id/delete' => 'users#delete'
  get 'users/:id/public' => 'users#show_public'
end
