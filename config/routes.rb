Townent::Application.routes.draw do
  resource :status
  
  resources :genres do
    resources :categories do
      resources :event_groups
    end
  end
  
  root to: 'status#show'
end
