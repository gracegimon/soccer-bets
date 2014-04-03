Quiniela::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  ## AUTHENTICATION ##
  get "sign_in" => "authentication#sign_in"
  post "sign_in"=> "authentication#login"
  get "signed_out" => "authentication#signed_out"
  get "change_password" => "authentication#change_password"
  get "forgot_password" => "authentication#forgot_password"
  put "forgot_password" => "authentication#send_password_reset_instructions"
  get "password_reset" => "authentication#password_reset"
  put "password_reset" => "authentication#new_password"
  get "sign_up" => "authentication#sign_up"
  post "sign_up" => "authentication#register"
  get "password_sent" => "authentication#password_sent"


  # USERS #

  resources :users do
    resources :score_boards do
    end
  end

  resources :score_boards do
    get "show_all", to: "score_boards#show_for_admin", on: :collection
    get "ranking", to: "score_boards#ranking", on: :collection
    get "show_round_of_16", to: "score_boards#show_round_of_16", on: :member
    get "show_quarter_finals", to: "score_boards#show_quarter_finals", on: :member
    get "show_semi_finals", to: "score_boards#show_semi_finals", on: :member
    get "show_finals", to: "score_boards#show_finals", on: :member
    get "wait", on: :member
    get "finish_phase", on: :member
    get "show_after_published", on: :member
    patch "update_active", on: :member

  end

  resources :team_stats do
    post "change_position", to: "team_stats#change_position"
  end

  resources :extra_phases do
    get "teams", to: "extra_phases#get_teams", on: :member
    get "players", to: "extra_phases#get_players", on: :member
  end

  resources :scores do

  end
  
  resources :tournaments do
  end

  get "/tournament/:tournament_id/score_boards/:id", to: "score_boards#tournament_score_board", as: "tournament_score_board"

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

  get '*not_found', to: 'application#error_404'

end
