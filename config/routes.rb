Townent::Application.routes.draw do
  
  ## Server status
  resource :status, only: %w(show)
  
  
  ## Events CRUD
  resources :events
  
  
  ## City selection interface
  resources :cities, only: %w(index show)
  
  ## Events search interface
  resources :genres, only: %w() do
    resources :events, only: %w(index)
    resources :categories, only: %w() do
      resources :events, only: %w(index)
    end
  end
  
  root to: 'events#index'
end
