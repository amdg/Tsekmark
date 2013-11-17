require 'api'

Tsekmark::Application.routes.draw do
  authenticated :user do
    #root :to => 'dashboard#index'
    root :to => 'sectors#index'
  end

  devise_for :users, :controllers => {:sessions => "sessions", :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }

  devise_scope :user do
    get "users/sign_out", :to => "sessions#destroy", :as => :destroy_user_session
    get "users/sign_in", :to => "sessions#create", :as => :create_user_session
  end



  mount Base => "/"
  #mount GrapeSwaggerRails::Engine => '/swagger'
  resources :authentications, only: :destroy

  namespace :dashboard do
    get :index
    get :switch
  end

  resources :locations

  get "/oauth2callback" => "invites#index"
  get "/invites/:provider/callback" => "invites#index"

  get "sectors/list", :to => 'sectors#list'
  get "regions/list", :to => 'regions#list'
  get "departments/:id", :to => 'departments#index'
  get "projects/:id", :to => 'projects#show'
  get "projects/region/:id", :to => 'projects#region'
  get "projects/department/:id", :to => 'projects#department'
  get "projects/department_list/:id", :to => 'projects#department_list'
  get "projects/area_list/:id", :to => 'projects#area_list'
  get "departments/sector_list/:id", :to => 'departments#sector_list'
  resources :sectors
  resources :regions

  resources :users
  root :to => "home#index"
end