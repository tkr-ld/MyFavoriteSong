Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :users, only: [:index, :show, :new, :create]
    resources :musicians, only: [:index, :show, :new, :create] do
        collection do
            get :search
        end
    end
    resources :setlists
    
end
