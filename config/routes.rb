Rails.application.routes.draw do
  resources :affiliations
  resources :contacts
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :contacts do
    get 'search', on: :collection
  end
  
  root to: "contacts#index"
end
