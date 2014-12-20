Rails.application.routes.draw do
  root 'static_pages#index'

  get 'static_pages/about'

  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :users, only: [:show, :index]

end
