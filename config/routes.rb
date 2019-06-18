Rails.application.routes.draw do
  

  get 'password_resets/new'

  get 'password_resets/edit'

  resources :users , only: [:create,:edit,:update,:show,:destroy]

  get '/users', to: 'users#index'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  root 'static_pages#home'

  get '/help',to:'static_pages#help' 

  get '/about',to:'static_pages#about'

  get '/contact',to:'static_pages#contact'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'

  delete '/logout',  to: 'sessions#destroy'

  resources :account_activations, only: :edit
  

  resources :password_resets,     only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
