Rails.application.routes.draw do
  root 'calendar#index'
  get 'calendar', to: 'calendar#index', as: :calendar_default
  get 'calendar/:year/:month', to: 'calendar#show', as: :calendar
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'entry/:id/destroy', to: 'entries#destroy', as: :entry_destroy
  post 'entry/create', to: 'entries#create', as: :entries

  get 'profile', to: 'userprofiles#show', as: :profile
  post 'profile/update', to: 'userprofiles#ajax_update', as: :profile_update
  
  # Special Pages
  get 'training/:topic', to: 'challenge#training', as: :training

  # Entry Challenges (admin)
  get 'challenge', to: 'challenge#show', as: :challenge
  post 'challenge/create', to: 'challenge#ajax_create', as: :challenge_create
  get 'ajax/cf/get_title/:pid', to: 'challenge#ajax_cf_get_title', as: :cf_get_title

  # Admin Manage Challenges
  get 'admin/challenge', to: 'challenge#handle', as: :admin_challenge




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
