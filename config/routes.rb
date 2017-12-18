Rails.application.routes.draw do
  root to: 'site#home'
  post '/signin' => 'google#signin'
  get '/calendar' => 'site#calendar'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
