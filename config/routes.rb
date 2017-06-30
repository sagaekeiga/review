Rails.application.routes.draw do
  root 'pages#home'
  get 'products/scraping'

  resources :products, :only => [:index, :create, :destroy, :update, :show]
  resources :reviews, :only => [:index, :destroy]
  resources :categories, :only => [:index, :create, :destroy, :update]

end
