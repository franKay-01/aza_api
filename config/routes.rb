Rails.application.routes.draw do
  # devise_for :users
  resources :transactions
  resources :auth, only: [:create]
  resources :users, only: [:create]

  get '/transaction_record/:uuid' => 'transactions#get_transaction'
  get '/get_transaction/:uuid' => 'transactions#get_transaction'
  post '/update_transaction/:uuid' => 'transactions#update_transaction'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
