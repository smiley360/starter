Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/articles", to: "articles#index"
  resources :user, controller: 'users'
  resources :review, controller: 'reviews'
  resources :attachment, controller: 'attachments'
end
