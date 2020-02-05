Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :tests
  root 'users#home'
  post '/users/register' => 'users#register'
  post '/users/getuser' => 'users#getUser'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  resources :jobs
  resources :users
  resources :skills

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
