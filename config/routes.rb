Rails.application.routes.draw do
  root "main#home"

  # User
  get "user/new"
  get "user/sign_in"
  get "user/:user_id", to: "user#show", as: :user
  post "user/create", as: :users
  post "timer/pb", to: "user#new_pb"

  # Sessions
  post "sessions/create", to: "sessions#create"
  post "user/logout", to: "sessions#destroy"

  # Posts
  get "post/:post_id", to: "posts#show", as: :post
  get "/community" => "posts#community"
  post "/community/new" => "posts#new"

  # Comments
  post "/comment/new" => "comments#new"

  # Likes
  post "/like" => "likes#create"

  # Main
  get "/timer" => "main#timer"
  get "/fcs" => "main#fcs"

  resources :user
end
