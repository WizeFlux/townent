Townent::Application.routes.draw do
  
  ## Server status
  resource :status, only: %w(show), controller: 'status'
  
  
  ## Events CRUD
  resources :events, except: %w(index)
  
  
  ## Eventgroups CRUD
  resources :event_groups, except: %w(index)
  
  
  ## Venues CRUD
  resources :venues, except: %w(index)
  
  
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
  
  root to: 'cities#index'
end
