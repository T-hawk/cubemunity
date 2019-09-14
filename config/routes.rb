Rails.application.routes.draw do
  root "main#home"
  get "user/new"
  get "user/sign_in"
  get "user/:user_id", to: "user#show", as: :user
  post "user/create", as: :users
  post "timer/pb", to: "user#new_pb"
  post "user/logout", to: "sessions#destroy"
  post "sessions/create", to: "sessions#create"
  get "/timer" => "main#timer"
  get "/community" => "posts#community"
  post "/community/new" => "posts#new"
  get "/fcs" => "main#fcs"

  resources :user
end
