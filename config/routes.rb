require 'api'

Tsekmark::Application.routes.draw do
  #mount Messaging::Engine => "/messaging"
  mount GrapeSwaggerRails::Engine => '/swagger'

  devise_for :messaging_users

  authenticated :user do
    root :to => 'dashboard#index'
  end

  devise_for :users, :controllers => {:sessions => "sessions", :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }

  devise_scope :user do
    get "users/sign_out", :to => "sessions#destroy", :as => :destroy_user_session
    get "users/sign_in", :to => "sessions#create", :as => :create_user_session
  end

  namespace :profiles do
    get :choose
    get :build
    post :create
  end

  mount Base => "/"

  post "follow/:type/:id", :to => "follows#create", :as => :follow
  delete "unfollow/:type/:id", :to => "follows#destroy", :as => :unfollow
  get "followings", :to => 'follows#followings'
  get "followers", :to => 'follows#followers'
  get "follower_list", :to => 'follows#follower_list'

  get 'business/edit', :to => 'businesses#edit'
  put 'business/update', :to => 'businesses#update'
  delete 'business/delete', :to => 'businesses#destroy'
  resources :businesses, :only => [:show, :new, :create]
  resources :business_categories, :only => :index
  resources :blasts
  resources :authentications, only: :destroy

  namespace :dashboard do
    get :index
    get :switch
  end

  resources :messages
  resources :conversations
  match "locations/add" => "locations#add"
  resources :locations
  resources :blasts do
    post :comment
    get :comments
  end

  get "/oauth2callback" => "invites#index"
  get "/invites/:provider/callback" => "invites#index"

  get "/contacts/:provider/callback", :to => "invites#index", :as => :import
  namespace :contacts do
    get :index
    get :failure, :to => "invites#failure"
    post :save
  end

  resources :users
  root :to => "home#index"
end