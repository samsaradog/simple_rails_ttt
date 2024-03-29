TicTacToe::Application.routes.draw do
  resources :players
  resources :sessions, only: [:new, :create, :destroy]
  
  root to: 'players#home'
  
  scope :controller => :sessions do
      match 'signin'  => :new
      match 'signout' => :destroy, via: :delete
  end
  
  scope :controller => :players do
      match 'signup'                  => :signup
      match '/leaders'                => :leaders
      match '/players/activate/:id'   => :activate
  end
  
  scope :controller => :tic_tac_toe do
    match 'computer_game'       => :computer_game
    match 'new_computer_game'   => :new_computer_game
    match 'human_move'          => :human_move
    
    # The above are for the computer vs.human game
    # The below are for the two human game
  
    match 'reset_two_player_game' => :reset_two_player_game
    match 'new_two_player_game'   => :initialize_game
    match 'two_player_move'       => :two_player_move
    
    match 'get_update'            => :get_update
    match 'join'                  => :join
    match 'invite'                => :invite
    
    match ':cipher' => :two_player_game
  end
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
