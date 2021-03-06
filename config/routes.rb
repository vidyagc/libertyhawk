Rails.application.routes.draw do
  get 'users/show'

  devise_for :users, :controllers => {:registrations => "registrations"}
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # post 'searches/create' => 'favorites#create'
  
  # resources :favorites, only: [:create, :destroy, :show]

  post 'favorites/create' => 'favorites#create'
  delete 'favorites/remove' => 'favorites#destroy'
  get 'bill' => 'searches#show'
  get 'favorite' => 'favorites#show'

delete 'favorites_remove_two' => 'favorites#destroy_search_bill'

  # as :user do
  #   get 'login', to: 'devise/sessions#new'
  #   delete 'logout', to: 'devise/sessions#destroy'
  # end
  
  get 'searches/', to: 'searches#index'
  
  get 'searches/sort', to: 'searches#sort'
  get 'searches/search', to: 'searches#search'
  get 'users/search', to: 'searches#search'
  
  # these are causing possible problems for when users are logged in and accidentally go to these routes (other action calls on search results page break).
  # need to add constraints... have a partial there instead of search box by itself? not sure that would work. Find way to have conditional, that routes don't 
  # exist if user signed in
  
  get '/welcome/search', to: 'searches#search'
  get '/search', to: 'searches#search'
  
  get 'sort', to: 'searches#sort' 
  
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
