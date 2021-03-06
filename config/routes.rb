Rails.application.routes.draw do
    root to: 'static_pages#home'

    get 'home', to: 'static_pages#home'
    get 'description', to: 'static_pages#description'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    
    resources :users, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        get :favorites
        get :joinlives
      end
    end
  
    resources :musicians, only: [:index, :show, :new, :create, :edit, :update] do
    end

    resources :setlists,except: [:index] do
      get 'edit/track', action: :edit_track
      resources :songs, only: [:create, :destroy]
    end
    
    resources :musician_relationships, only: [:create, :destroy]
    resources :setlist_relationships, only: [:create, :destroy]

    get 'auth/:provider/callback', to: 'sessions#create'

    if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end
    
end
