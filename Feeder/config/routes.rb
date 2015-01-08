Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get ':username', to: 'users#show', as: :user
  get ':username/edit', to: 'users#edit', as: :edit_user
  patch ':username', to: 'users#update'
  delete ':username', to: 'users#destroy', as: :destroy_user

  scope ":username" do
    resources :feeds
  end

  root 'users#index'
  
end
