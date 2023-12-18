Rails.application.routes.draw do
  root "static_pages#root"
  post "/auth/:provider/callback", to: "sessions#create"

  get "up" => "rails/health#show", as: :rails_health_check

end
