Rails.application.routes.draw do
  
  resources :users , only:([:create])

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  root 'static_pages#home'

  get '/help',to:'static_pages#help' 

  get '/about',to:'static_pages#about'

  get '/contact',to:'static_pages#contact'

  get "users/:id", to: 'users#show', as: :user

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
