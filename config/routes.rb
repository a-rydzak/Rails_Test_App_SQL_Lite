Rails.application.routes.draw do
# All restful routes for Productrs
get "products" => "products#index"            #A page that displays all the products.
get "products/new" => "products#new"          #A page that allows the user to add a new product
post "products" => "products#create"          #A URL that processes information submitted from the new page to create a product        
get "products/:id" => "products#show"         #A page that displays information for the product with an id of 2
get "products/:id/edit" => "products#edit"    #A page that allows the user to edit existing product information
patch "products/:id" => "products#update"     #A URL that processes information submitted from the edit page to update a product
delete "products/:id" => "products#destroy"   #A URL that allows a product to be deleted
# -------------------you can also just do this resources :products

# Can create your own
get "profile" => "users#show"

# It is important to understand the type of information we want to pass around 
# and what type of action has just happened. If a user just registered at your 
# site and the information was successfully saved to your database, then you are 
# going to want to do a redirect_to. Why? Because if you submit a form and then a 
#   new view is rendered, you only sent one HTTP request; if you were to refresh the 
#   page, it would ask you to resubmit the form data and could possibly save the user 
#   again in the database, resulting in duplicate entries. By using redirect_to then when 
#   the user refreshes the page, he is simply redoing the redirect_to action and loading a fresh new page

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
