Rails.application.routes.draw do
  resources :photos
  resources :albums
  resources :events
  resources :clients

  post 'signin', controller: :signin, action: :create
  delete 'signin', controller: :signin,  action: :destroy
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get ':token/event', controller: :event, action: :client
end
