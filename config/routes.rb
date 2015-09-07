Rails.application.routes.draw do
  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'welcome#index'

  # Example of regular route:
  #resources :categories, only: [:index, :new, :create]
  get ':name' => 'categories#show', as: :category
  #get ':name/edit' => 'categories#edit', as: :edit_category
  #match ':name' => 'categories#update', via: [:put, :patch]
  #delete ':name' => 'categories#destroy'

  scope ':category_name' do
    #resources :articles, only: [:create]
    #get 'new' => 'articles#new', as: :new_article
    get ':name' => 'articles#show', as: :article
    #get ':name/edit' => 'articles#edit', as: :edit_article
    #match ':name' => 'articles#update', via: [:put, :patch]
    #delete ':name' => 'articles#destroy'
  end

=begin
  get ':category_name/:name' => 'articles#show', as: :article
  get ':category_name/:name/edit' => 'articles#edit', as: :edit_article
  match ':category_name/:name' => 'articles#update', via: [:put, :patch]
  delete ':category_name/:name' => 'articles#destroy'
=end 

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
