require 'grape'

module Gas
  class API < Grape::API
    prefix "api"
    version 'v1', :using => :path

    namespace :ga do
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
        { total: result['total'], from: params[:from] || 0, result: result['hits'].map { |hit|
          source = hit[map_key]
          source['upvotes'] = Vote.where(general_appropriation_id: source['budget_id'], vote_type: 1).count
          source['downvotes'] = Vote.where(general_appropriation_id: source['budget_id'], vote_type: 2).count
          if current_user then
            v = Vote.find_by_user_id_and_general_appropriation_id(current_user.id, source['budget_id'])
            source['vote'] = v ? v.vote_type : nil
          end
          source
        } }
      end
    end
  end
end
