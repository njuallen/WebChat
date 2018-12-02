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

  get 'homes/login' => 'homes#login'
  get 'homes/register' => 'homes#register'
  get 'sessions/login' => 'sessions#new'
  post 'sessions/login' => 'sessions#create'
  post 'sessions/register' => 'sessions#register'
  delete 'sessions/logout' => 'sessions#destroy'
end
