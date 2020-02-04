Rails.application.routes.draw do
  root 'users#home'
  get 'users/new'
  post '/users/register' => 'users#register'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  resources :jobs
  resources :users
  resources :skills

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
