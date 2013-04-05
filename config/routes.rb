Townent::Application.routes.draw do
  
  
  ## Server status
  resource :status, only: %w(show), controller: 'status'  
  
  
  ## Eventgroups CRUD
  resources :event_groups, except: %w(index)
  
  
  ## Venues CRUD
  resources :venues, except: %w(index)
  
  
  ## Events CRUD
  resources :events
  
  
  ## City selection interface
  resources :cities, only: %w(index) do
    resources :events, only: %w(index)
    resources :genres, only: %w() do
      resources :events, only: %w(index)
      resources :categories, only: %w() do
        resources :events, only: %w(index)
      end
    end
  end
  
  
  ## Events search interface
  root to: 'events#index'
end
