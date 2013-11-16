require 'grape'

module Users

  class API < Grape::API

    prefix "api"
    version 'v1', :using => :path

    namespace :user do
      # Current User
      desc "Returns the currently logged in user"
      get 'me' do
        authenticated_user
        present current_user, with: User::Entity
      end

      # Show User
      desc "Returns the info about a user"
      get '/:id' do
        authenticated_user
        present User.find(params[:id]), with: User::Entity
      end

      # Login endpoint
      desc "Returns the user described by credentials. Includes the auth token"
      params do
        requires :email, :type => String, :desc => "User's email address"
        requires :password, :type => String, :desc => "User's account password"
      end
      post 'login' do
        resource = User.find_for_database_authentication(:email => params[:email])
        access_denied! unless resource

        if resource.valid_password?(params[:password])
          resource.reset_authentication_token!
          resource.expose_token = true
          present resource, :auth_token => resource.authentication_token
        else
          access_denied!
        end
      end


    end


  end
end
