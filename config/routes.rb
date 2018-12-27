Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :messages do
    collection do
      delete :destroyall
    end
  end


  root 'homes#home'

  get 'sessions/new' => 'sessions#new'
  post 'sessions/create' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'

  get 'users/new' => 'users#new'
  post 'users/create' => 'users#create'
  get 'users/search' => 'users#search'
  post 'users/search' => 'users#search_resp'
  get 'user/:id' => 'users#show'
  get 'user/:id/edit' => 'users#edit'
  patch 'user/:id/update' => 'users#update'
  get 'user/:id/delete' => 'users#delete'
  get 'user/:id/public' => 'users#show_public'

  post 'friendships/request' => 'friendships#request_friendship'
  post 'friendships/grant' => 'friendships#grant_friendship'
  get 'friendships/requests' => 'friendships#my_friendship_request'
  get 'friendships/grants' => 'friendships#my_friendship_grant'
  get 'friendships/finished' => 'friendships#finished_friendship_requests'

  get 'chats/bot' => 'chats#bot'
  post 'chats/bot_chat' => 'chats#bot_chat'
  resources :friendships
  resources :user
  resources :chats
end
