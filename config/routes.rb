Rails.application.routes.draw do
  devise_for :registrations, class_name: "Admin::Registration"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :admin, skip: :all
  devise_for :admin_database_authentications, class_name: "Admin::DatabaseAuthentication",
    path_prefix: "admin", path: "auth", path_names: { sign_in: "login", sign_out: "logout" }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
