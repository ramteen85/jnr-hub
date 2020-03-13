Rails.application.routes.draw do
  # post 'user_token' => 'user_token#create'
  resources :tests
  root 'users#home'
  post '/users/register' => 'users#register'
  post '/job-applicants' => 'users#jobapplicants'
  post '/users/getuser' => 'users#getUser'
  get '/users/profile' => 'users#profile'
  post '/users/profile' => 'users#profile'
  post '/users' => 'users#create'
  post '/users/update' => 'users#update'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  delete '/jobs' => 'jobs#destroy'
  post '/myjobs' => 'jobs#myjobs'
  post '/applications' => 'applications#create'
  get '/deleteapplications' => 'applications#delete'
  resources :jobs
  resources :users, except: [:update]
  resources :tokens, only: [:create]
  resources :skills

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
