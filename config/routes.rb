Rails.application.routes.draw do
  get 'users/show'

  devise_for :users
  
devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end

# post 'searches/create' => 'favorites#create'
  
# resources :favorites, only: [:create, :destroy, :show]

post 'favorites/create' => 'favorites#create'
delete 'favorites/remove' => 'favorites#destroy'
get 'bill' => 'searches#show'
get 'favorite' => 'favorites#show'
get 'users/search' => 'searches#search'

delete 'favorites_remove_two' => 'favorites#destroy_search_bill'

  # as :user do
  #   get 'login', to: 'devise/sessions#new'
  #   delete 'logout', to: 'devise/sessions#destroy'
  # end
  
  get 'searches/', to: 'searches#index'

  get 'searches/search', to: 'searches#search'

# post 'searches/create', to: 'searches#create'
  
  # get "/users/sign_out"
  
  get 'welcome/index'

  get 'welcome/about'

  get 'index/about'
  
  root 'welcome#index'
  
  get 'members/:chamber', to: 'members#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
