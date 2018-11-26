Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :users, only: [:index, :show, :new, :create] do
        member do
          get :favorites
        end
    end
  
    resources :musicians, only: [:index, :show, :new, :create] do
        collection do
            get :search
        end
    end
    resources :setlists do
        member do
            patch :add_song
        end
    end
    
    resources :musician_relationships, only: [:create, :destroy]
    
end
