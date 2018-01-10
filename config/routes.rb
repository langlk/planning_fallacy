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

  get '/checkin' => 'checkins#new'
  post '/checkin' => 'checkins#create'

  get '/calendar' => 'site#calendar'
  get '/profile' => 'site#profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post '/signup' => 'users#create'
      post   "/signin" => "sessions#create"
      delete "/signout" => "sessions#destroy"

      get '/user' => 'users#show'
      get '/events' => 'events#index'
      post '/checkin' => 'checkins#create'
    end
  end
end
