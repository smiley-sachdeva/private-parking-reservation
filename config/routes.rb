Rails.application.routes.draw do  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    registration: 'signup',
    sign_out: 'logout'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :parkings, except: [:edit, :new] do
    resources :features, except: [:edit, :new]
    resources :slots, except: [:edit, :new]
  end

  resources :slots, only: [] do
      resources :parking_logs, only: [:index, :create, :show]
  end

  patch 'slots/:slot_id/checkout' => 'parking_logs#checkout'

  resources :reservations do
    member do
      patch 'cancel'
    end    
  end
end
