Rails.application.routes.draw do
  root to: 'welcome#home'
  resources :check_out_logs
  resources :authors
  resources :genres
  resources :books
  resources :users

  #Special Checkout paths
  #get '/check_out/:book_id' => 'check_out_logs#new', as: 'check_out_page'

  # Nested Routes
  resources :books, only: [:show] do
    resources :check_out_logs, only: [:new]
    post '/check_out_logs/check_in/:id' => 'check_out_logs#check_in', as: 'check_in'
  end

  resources :users, only: [:show] do
    resources :books, only: [:index]
  end

  get '/signin' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  post '/signout' => 'sessions#destroy'
  get '/auth/google_oauth2/callback' => 'sessions#create'
  get '/overdue_books' => 'books#overdue', as: 'overdue'
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
