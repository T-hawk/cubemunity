Rails.application.routes.draw do
  root "main#home"

  # User
  get "user/new"
  get "user/sign_in"
  get "user/:user_id", to: "user#show", as: :user
  post "user/create", as: :users
  post "user/follow", to: "user#follow"
  post "user/unfollow", to: "user#unfollow"

  # Personal Best
  post "timer/pb", to: "personal_bests#change"

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

  # API
    # User
    get "/api/user/:user_id" => "api#get_user"
    get "/api/user/pb/:user_id" => "api#get_user_pb"
    post "/api/sessions/create" => "api#create_session"
    post "/api/user/create" => "api#create_user"

    # Post
    get "api/posts" => "api#get_posts"
    post "api/posts/create" => "api#create_post"
    get "/api/comments/:post_id" => "api#get_post_comments"

  resources :user
end
