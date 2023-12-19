Rails.application.routes.draw do
  root "static_pages#root"

  get "/bookmarks", to: "static_pages#root"

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"

  get "up" => "rails/health#show", as: :rails_health_check

end
