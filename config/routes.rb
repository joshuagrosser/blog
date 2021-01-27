Rails.application.routes.draw do

  get 'articles/index'
  post '/auth/developer/callback', to: 'articles#callback'
  get '/auth/failure', to: 'articles#failure'
end
