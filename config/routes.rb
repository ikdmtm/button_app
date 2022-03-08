Rails.application.routes.draw do
  
  devise_for :users
  root to: 'posts#index'
  get "/users/:id/like" => "users#like"
  resources :users, only: [:index, :show]
  get '/posts/liked' => 'posts#rank'
  get '/posts/search' => 'posts#search' #ボタンの検索
  post "/posts/:id/button" => "posts#button"
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  get "/terms" => "home#terms"
  get "/privacy" => "home#privacy"
end
