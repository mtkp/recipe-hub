Recipehub::Application.routes.draw do

  resources :recipes, except: [:index] do
    resources :ingredients, only: [:new, :edit, :update, :create, :destroy]
    resources :directions, only: [:new, :edit, :update, :create, :destroy]
    resources :stars, only: [:create, :index]
    delete 'stars' => 'stars#destroy'
    resources :forks, only: [:index]
    post :fork, on: :member
    post :branch, on: :member
    # resource :fork, only: [:create]
    # resource :branch, only: [:create]
  end

  resources :collections, only: [:show] do
    resources :branches, only: [:update, :destroy]
  end
  
  devise_for :users
  devise_scope :user do
    get 'sign_in' => 'devise/sessions#new'
    get 'sign_out' => 'devise/sessions#destroy'
    get 'sign_up' => 'devise/registrations#new'
  end
  
  get ':username', to: 'users#show', as: :user
  get ':username/recipes', to: 'recipes#index', as: :user_recipes
  get ':username/stars', to: 'stars#index', as: :user_stars
  get ':username/collections', to: 'collections#index', as: :user_collections

  root 'static_pages#home'

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
