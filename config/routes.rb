DiningWebsite::Application.routes.draw do

  root "show#home"

  #admin
  scope '/admin' do
    get "admin_index" =>'admin#admin_index'
    get 'add_new_merchant' => 'admin#add_new_merchant'
    get 'modify_merchant_info' =>'admin#modify_merchant_info'
    get 'save_modify_merchant_id' =>'admin#save_modify_merchant_id'
    get 'roll_images_manager' => 'admin#roll_images_manager'
    get 'label_flavour_list' => 'admin#label_flavour_list'
    get 'label_site_list' => 'admin#label_site_list'
    get 'label_dish_style_list' => 'admin#label_dish_style_list'
    get '/set_home_ad'=>'admin#set_home_ad'
    get '/set_bg_logo'=>'admin#set_bg_logo'
    get '/set_about_us'=>'admin#set_about_us'
    get '/set_terms_conditions'=>'admin#set_terms_conditions'
    get '/set_privacy_security'=>'admin#set_privacy_security'

    post 'add_new_merchant' =>'admin#save_new_merchant'
    post 'modify_merchant_info' =>'admin#update_merchant_info'
    post 'save_new_label' => "admin#save_new_label"
    post 'delete_label' => 'admin#delete_label'
    post 'process_roll_images' => 'admin#process_roll_images'
    post 'delete_roll_image' => 'admin#delete_roll_image'
    post "/pass_check"=>'admin#pass_check'
    post "/send_pass_check_email"=>"admin#send_pass_check_email"
    post '/save_about_us'=>'admin#save_about_us'
    post '/save_terms_conditions'=>'admin#save_terms_conditions'
    post '/save_privacy_security'=>'admin#save_privacy_security'
    post '/process_home_ad'=>'admin#process_home_ad'
    post '/process_site_photo'=>'admin#process_site_photo'

    delete 'delete_merchant' => 'admin#delete_merchant'
  end

  #user
  get 'login' => 'merchant#login'
  scope '/merchant' do
    get "merchant_index" =>'merchant#merchant_index'
    get "logout" => 'merchant#logout'
    get 'dishes_management' => 'merchant#dishes_management'
    get 'add_new_dish' => 'merchant#add_new_dish'
    get 'modify_dishes_info' => 'merchant#modify_dishes_info'
    get 'save_modify_dish_id' => 'merchant#save_modify_dish_id'


    post "create_login_session" =>"merchant#create_login_session"
    post 'merchant_index' => "merchant#save_merchant_modify_info"
    post 'save_address' => 'merchant#save_address'
    post 'update_merchant_labels' => 'merchant#update_merchant_labels'
    post 'add_new_dish' => 'merchant#save_new_dish'
    post 'modify_dishes_info' => 'merchant#update_dishes_info'
    post 'update_modify_dish_labels' => 'merchant#update_modify_dish_labels'
    post 'save_add_dish_labels' => 'merchant#save_add_dish_labels'
    post 'new_label' =>'merchant#add_new_label'

    delete 'delete_addr' => 'merchant#delete_address'
    delete 'delete_dish' => 'merchant#delete_dish'
  end

  #show
  get 'home' => 'show#home'
  get 'home_label_detail' => 'show#home_label_detail'
  get 'restaurant_detail' => 'show#restaurant_detail'
  get 'about' => 'show#footer_about'
  get 'terms_conditions' => 'show#footer_terms_conditions'
  get 'privacy_security' => 'show#footer_privacy_security'
  get 'all_site_labels' => 'show#all_site_labels'
  get 'not_find_merchant_show' => 'show#not_find_merchant_show'
  get '/new_merchant'=>'show#register_merchant'
  get '/submit_success'=>'show#submit_success'
  get '/forget_password'=>'show#forget_password'
  get '/modify_password'=>'show#modify_password'
  get '/site_label_detail'=>'show#site_label_detail'

  post 'save_label_content_to_session' => 'show#save_label_content_to_session'
  post '/save_header_label_content_to_session'=>'show#save_header_label_content_to_session'
  post "send_mail" => 'show#send_mail'
  post '/new_merchant'=>'show#process_register_merchant'
  post '/new_user'=>'show#create_new_user'
  post '/new_comment'=>"show#new_comment"
  post '/user_login'=>'show#user_login'
  post '/recover_password'=>'show#recover_password'
  post '/new_password'=>'show#process_new_password'
  post '/delete_favor'=>'show#delete_favor'
  post '/add_favor'=>'show#add_favor'

  delete "/user_logout" => "show#user_logout"


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
