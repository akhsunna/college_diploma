Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, :students, :teachers

  resources :subjects do
    get 'delete'
  end

  match 'teachers/new_invite_code' => 'teachers#new_invite_code', :via => :post
  match 'teachers/delete_invite_codes' => 'teachers#delete_invite_codes', :via => :post

  resources :folders do
    get 'delete'
    put 'favourite'
    put 'visible'
  end

  resources :sub_files do
    get 'delete'
    put 'favourite'
    put 'visible'
  end

  resources :groups do
    put 'subject'
    get 'invite_codes'
  end

  post '/groups/export', to: 'groups#export', as: 'groups_export'

  resources :specialities do
    get 'delete'
  end

  resources :favourites

  root 'subjects#index'



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
