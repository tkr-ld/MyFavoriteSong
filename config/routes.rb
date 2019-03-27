Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :users, only: [:index, :show, :new, :create] do
        member do
          get :favorites
          get :joinlives
        end
    end
  
    resources :musicians, only: [:index, :show, :new, :create, :edit, :update] do
    end
    
    resources :setlists,except: [:index] do
        get :detail_edit, action: :detail_edit
        member do
            patch :add_song
            delete :del_song
        end
    end
    
    resources :musician_relationships, only: [:create, :destroy]
    resources :setlist_relationships, only: [:create, :destroy]

    if Rails.env.development?
        mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end
    
end
