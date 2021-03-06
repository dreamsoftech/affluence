Affluence2::Application.routes.draw do



  

  
  resources :discussions, :only => [:index, :new, :create, :update] do
    end
  get "activities/index"

  get "activities/connections"

  get "offers/index"

  get "offers/new"

  get "offers/edit"

  get "offers/create"

  get "offers/update"

  get "offers/show"


  ActiveAdmin.routes(self)


  match 'home' => 'home#index'


  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions", :passwords => 'passwords', :invitations => 'users/invitations'}
  devise_scope :user do
    get "/users/sign_in" => "welcome#index"

    get "/users/invitations/contacts" => "users/invitations#get_contacts", :as => :get_contacts
    post "/users/invitations/contacts" => "users/invitations#import_contacts", :as => :import_contacts

    match "/users/invitations/contacts_provider_callback" => "users/invitations#contacts_provider_callback", :as => :contacts_provider_callback

  end
 
  match "states_of_country", :to => "application#states_of_country"

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

  resources :users, :only => :show do
    resources :conversations, :only => [:index, :show, :new, :create, :update] do
      get :autocomplete_profile_full_name, :on => :collection
      get :archive
      get :unarchive
      get :confirm, :on => :collection
    end
    resources :photo_streams do
      post :create_photo
      delete 'photo/:id' => :destroy_photo, :as => 'photo'
    end
  end

  resources :photo_streams  

  # Sample resource route with options:
  resources :events do
    member do
      post :register
      get :delete_image
    end
    #
    collection do
      get :home_page_events
      get :landing_page_events
      get :confirm
      get :events_schedules
    end
  end

  resources :home do

  end

  resources :verfications

  resources :photos

  resources :concierges do
    member do
      post :call
    end
  end


  resources :profiles  do
    collection do
      get :confirm
      get :confirm_credit_card_info
      get :profile_session
      get :check_avilability
      get :autocomplete_interest_name 
      get :autocomplete_expertise_name
      get :autocomplete_association_name
      get :update_notifications
      get :user_plan
      get :billing_info_confirm
      get :billing_info_update_confirm
      post :update_plan
      get :edit_privacy
      get :update_privacy
      get :cancel_membership
      get :delete_account
    end

    member do
      get :set_notification_complete
    end
  end


  #  match 'profile/confirm' => 'profile#confirm', :as => :confirm_profile
  #  match 'profile/confirm_credit_card_info' => 'profile#confirm_credit_card_info', :as => :confirm_credit_card_info_profile



  resources :members, :except => [:show] do
    collection do
      get :latest
      get :find_members
      get :search
      get :delete_connection
    end
  end

  resources :offers do
    collection do
      get :latest
      get :confirm
    end
    member do
      get :activate
    end
  end

  resources :activities do
    collection do
      get :latest
    end
  end

  resources :orders
  resources :wineshares
  resources :welcome
  
  resources :twilio_calls do
    collection do
      get :receive_call
      post :status_call_back
    end
  end

  resources :promotions do
    member do
      get :become_premium_member
    end
  end


  match "api/user/sign_in" => "api#user_sign_in", :ssl => :required
  match "api/postback" => "api#postback", :ssl => :required
  match "api/callback_test" => "api#callback_test", :ssl => :required
  post "api/vincompass/validate_tokens" => "api#validate_tokens", :ssl => :required
  post "api/vincompass/authorize/application" => "api#authorize_application", :ssl => :required
  post "api/vincompass/authorize/user" => "api#authorize_user", :ssl => :required
  post "api/vincompass/activity_post" => "api#activity_post", :ssl => :required
  post "api/vincompass/v2/activity_post" => "api#activity_post_v2", :ssl => :required

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
  root :to => 'welcome#index'


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  match '*url' => 'welcome#index'
end
