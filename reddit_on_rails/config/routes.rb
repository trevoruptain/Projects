Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  resources :subs, except: [:destroy]

  resources :posts, except: %i( destroy index )

  resource :session, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
