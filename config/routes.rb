Rails.application.routes.draw do
  get 'tokens/create'
  # post 'user_token' => 'user_token#create'
  resources :tests
  root 'users#home'
  post '/users/register' => 'users#register'
  post '/users/getuser' => 'users#getUser'
  get '/users/profile' => 'users#profile'
  post '/users/profile' => 'users#profile'
  post '/users' => 'users#update'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  resources :jobs
  resources :users, except: [:update]
  resources :tokens, only: [:create]
  resources :skills

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
