Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#home', page: 'home'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :bands do
    resources :opinions, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :reactions, only: [:create]
    end
    resources :events do
      resources :attendances, only: [:index, :create, :destroy]
    end
    resources :posts do
      resources :comments, only: [:new, :create, :edit, :update, :destroy]
    end
    resources :albums do
      resources :tracks
    end
  end

  post '/bands/:band_id/add', to: 'bands#add_member', as: 'member_add'
  delete '/bands/:band_id/remove/:id', to: 'bands#remove_member', as: 'member_remove'

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
