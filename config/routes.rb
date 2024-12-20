#routes provide RESTful routes for events
Rails.application.routes.draw do
  resources :events do
    post 'buy', on: :member #custom route for buy tickets
    resources :comments, only: [:index, :create, :destroy] #manage comments
  end
end