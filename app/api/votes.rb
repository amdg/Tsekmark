require 'grape'

module Votes

  class API < Grape::API

    prefix "api"
    version 'v1', :using => :path

    namespace :votes do
      # Show votes
      desc "Shows only one vote"
      get '/:id' do
        authenticated_user
        present Vote.find(params[:id]), with: Vote::Entity
      end

      # List all votes
      desc "Lists all votes for a GA"
      params do
        requires :id, :type => Integer, :desc => "GA id"
      end
      get '/ga/:id' do
        authenticated_user
        ga = GeneralAppropriation.find params[:id]
        not_found! unless ga
        present ga.votes
      end

      # Post a vote
      desc "Post a vote"
      params do
        group :vote do
          requires :comment, :type => String, :desc => "Vote Comment"
          requires :vote_type, :type => Integer, :desc => "Vote Type"
        end
      end
      post '/ga/:id' do
        authenticated_user
        ga = GeneralAppropriation.find params[:id]
        not_found! unless ga

        vote_params = params[:vote]
        # Paperclip does not interpret a Hashie object from Grape/Rack
        # so instantiate it as a ActionDispatch::Http::UploadedFile
        vote_params[:photo] = ActionDispatch::Http::UploadedFile.new(vote_params[:photo]) if vote_params[:photo]
        vote = ga.votes.new vote_params

        if vote.save!
          post_to_social_media(vote)
          present vote
        else
          bad_request!
        end
      end

    end


  end
end
