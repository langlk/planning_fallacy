Rails.application.routes.draw do
  root to: 'site#home'
  post '/signin' => 'google#signin'
  post '/storeauthcode' => 'google#authorize'
  get '/calendar' => 'site#calendar'
  get '/calendar_auth' => 'site#calendar_auth'
  get '/users/auth/google_oauth2' => 'site#calendar_open'
  get '/oauth' => 'google#oauth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
