Rails.application.routes.draw do
  root 'static_pages#index'

  get 'static_pages/about'

  devise_for :users, :controllers => {registrations: 'registrations'}
  
  resources :users, only: [:show, :index] do
		resources :debts, except: [:index, :show]
	end
  put '/complete', to: 'debts#complete', as: :complete	
end
