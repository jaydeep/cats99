Cats99::Application.routes.draw do

  resources :cats
  resources :cat_rental_requests, only: [:new, :create] do
    post "approve", to: "cat_rental_requests#approve"
    post "deny", to: "cat_rental_requests#deny"
  end

	resources :users
	resource :session, :only => [:new, :create, :destroy]
end
