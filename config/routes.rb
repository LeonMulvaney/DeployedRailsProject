Rails.application.routes.draw do
  resources :prescriptions
  resources :hospital_referrals
  resources :appointments
  resources :patients do
  	  resources :visits
  	    collection { post :import } # Handle CSV imports - Post 
  	end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'


end
