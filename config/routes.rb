Rails.application.routes.draw do
  root "articles#index"

  get "/articles", to: "articles#index"
  get "/articles/:id", to: "articles#show"
  get "/about", to: "about#index"
  get "/portfolio", to: "portfolio#index"
  get "/services", to: "services#index"
  get "/contact_form", to: "contact_form#new"
  get "/posts/:id", to: "posts#show"
  resources :contact_form, only: %i[new create]
  
  resources :posts do
    collection do
      get 'filter_by_tag/:id', to: 'posts#filter_by_tag', as: :filter_by_tag
      get 'filter_by_category/:id', to: 'posts#filter_by_category', as: :filter_by_category
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
