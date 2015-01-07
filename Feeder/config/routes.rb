Rails.application.routes.draw do

  get '/login', to: 'users#login'

  resources :users do
    resources :feeds
  end

  root 'users#index'
  
end
