Rails.application.routes.draw do
  root to: 'site#home'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/add_account' => 'accounts#new'
  get '/authorize' => 'accounts#authorize'
  get '/oauth_callback' => 'accounts#oauth_callback'

  get '/signin' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  delete '/sessions' => 'sessions#destroy'

  resources :checkins, only: [:new, :create]

  get '/calendar' => 'site#calendar'
  get '/calendar_auth' => 'site#calendar_auth'
  get '/users/auth/google_oauth2' => 'site#calendar_open'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
