require 'grape'

module Gas

  class API < Grape::API

    prefix "api"
    version 'v1', :using => :path

    namespace :ga do
      # Show ga
      desc "Shows only one ga"
      get '/:id' do
        authenticated_user
        present GeneralAppropriation.find(params[:id]), with: GeneralAppropriation::Entity
      end

      # List all gas per department
      desc "Lists all GAs of a department"
      params do
        requires :id, :type => Integer, :desc => "department id"
      end
      get '/department/:id' do
        authenticated_user
        dept = Department.find params[:id]
        not_found! unless dept

        present dept.general_appropriations
      end

      # List all gas per area/region
      desc "Lists all GAs in an area"
      params do
        requires :id, :type => Integer, :desc => "GA id"
      end
      get '/area/:id' do
        authenticated_user
        area = Area.find params[:id]
        not_found! unless area

        present area.general_appropriations
      end

      # List all gas per area/region
      desc "Lists all GAs of the project owner"
      params do
        requires :id, :type => Integer, :desc => "GA id"
      end
      get '/owner/:id' do
        authenticated_user
        owner = Owner.find params[:id]
        not_found! unless owner

        present owner.general_appropriations
      end

      desc "List all budget items matching query"
      params do
        requires :q, type: String
        optional :fields, type: String
        optional :size, type: Integer
        optional :from, type: Integer
      end
      get 'list' do
        options = { q: params[:q], sort: 'budget_total:desc' }
        [ :fields, :size, :from ].each do |opt|
          options.merge!({opt => params[opt]}) if params[opt]
        end
        response = search_client.search(options)
        result = response['hits']
        map_key = params[:fields] ? 'fields' : '_source'
        { total: result['total'], from: params[:from] || 0, result: result['hits'].map { |hit| hit[map_key] } }
      end

    end


  end
end
