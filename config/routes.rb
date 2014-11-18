Rails.application.routes.draw do

  root "home#index"

  #Business

  post "business-signup" => "business#signup_process"
  post "business/save" => "business#save_business"

  get "business-signup" => "business#signup"
  get "business/:id" => "business#business_show"

  #User

  post "/newuser" => "user#signup_process"
  post "/login" => "user#login_process"
  get "/logout" => "user#logout_process"

  #Event

  get "events" => "event#index"
  get "event/new" => "event#new"
  get "events/:id" => "event#show"
  post "event/new" => "event#new_event_process"
  post "event/images" => "event#image_upload"

  #Blog

  get "blog/new" => "blog#new"
  post "blog/new" => "blog#create"
  post "blog/images" => "blog#image_upload"
  get "blog/me" => "blog#index_personal"
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
