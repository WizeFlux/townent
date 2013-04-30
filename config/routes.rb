Townent::Application.routes.draw do
  
  
  ## Server status
  resource :status, only: %w(show), controller: 'status'  
  
  
  ## Eventgroups CRUD
  resources :event_groups
  
  resources :genres, only: %w() do
    resources :event_groups, only: %w(index)
    resources :categories, only: %w() do
      resources :event_groups, only: %w(index)
    end
  end
  
  ## Venues CRUD
  resources :venues, except: %w(index)

  ## Search namespace
  namespace :search do
    resources :event_groups, only: %w(index)
    resources :events, only: %w(index)
    resources :venues, only: %w(index)
    resources :landing, only: %w(index)
    
    root to: 'landing#index'
  end
  
  ## Events CRUD
  resources :events
  
  
  ## City selection interface
  resources :cities, only: %w() do
    resources :events, only: %w(index)
    resources :genres, only: %w() do
      resources :events, only: %w(index)
      resources :categories, only: %w() do
        resources :events, only: %w(index)
      end
    end
  end
  
  
  root to: 'events#index'
end
