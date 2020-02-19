Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'

  scope "/", defaults: { format: :json } do
    resources :users, except: [:index, :destroy]
    resources :posts
    resources :comments, only: [:create]

    post "/auth/login", to: "authentication#login"
  end
end

