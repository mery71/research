Rails.application.routes.draw do
 
   use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end

  namespace :api do
    post "login"  => "sessions#create"
    delete "logout" => "sessions#destroy"
     resources :users
  end
  get  "login" => "session#new"
  post "login"=>"session#create"
  delete "logout"=>"session#destroy"

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
