Townent::Application.routes.draw do
  resource :status, only: %w(show)
  
  resources :events
  
  resources :genres, only: %w() do
    resources :events, only: %w(index)
    resources :categories, only: %w() do
      resources :events, only: %w(index)
    end
  end
  
  
  root to: 'status#show'
end
