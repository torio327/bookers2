Rails.application.routes.draw do
  root to: "homes#top"
  get "/home/about"=>"homes#about"
  get "/users"=>"users#index"
 
  resources :books,only:[:new, :create, :index, :show, :destroy,:update,:edit] do
     resource :favorites,only:[:create, :destroy]
     resources :book_comments,only: [:create,:destroy]
  end
  devise_for :users
  resources:users,only:[:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
