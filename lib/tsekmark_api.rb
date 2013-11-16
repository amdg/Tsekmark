class TsekmarkAPI < Grape::API
  version 'v2', using: :path
  format :json

  helpers do
    def current_user
      @current_user ||= User.authorize!(env)
    end

    def authenticate!
      error!('Unauthorized', 401) unless current_user
    end

    def search_client
      @es_client ||= Elasticsearch::Client.new(host: Rails.application.config.es_host)
    end
  end

  resource :summary do
    get :sectors do
      {
          name: "Sectors",
          children: [
              {
                  name: "Social Services",
                  children: [
                      {name: "Social Services", upvotes: 3123, size: 39323, downvotes: 323, buzz: 25, count: 1000}
                  ]
              },
              {
                  name: "General Public Service",
                  children: [
                      {name: "General Public Service", upvotes: 350, size: 3432938, downvotes: 36, buzz: 8, count: 1500}
                  ]
              },
              {
                  name: "Debt Burden",
                  children: [
                      {name: "Debt Burden", upvotes: 30, size: 343338, downvotes: 563, buzz: 55, count: 2000}
                  ]
              },
              {
                  name: "Defense",
                  children: [
                      {name: "Defense", upvotes: 150, size: 393238, downvotes: 78, buzz: 1, count: 800}
                  ]
              },
              {
                  name: "Economic Services",
                  children: [
                      {name: "Economic Services", upvotes: 250, size: 543938, downvotes: 383, buzz: 99, count: 1200}
                  ]
              }
          ]
      }

    end
    get :regions do
      {
          name: "Regions",
          children: [
              {
                  name: "Region I",
                  children: [
                      {name: "Region I", upvotes: 3123, size: 39323, downvotes: 323, buzz: 25, count: 1000}
                  ]
              },
              {
                  name: "Region IV",
                  children: [
                      {name: "Region IV", upvotes: 31, size: 393, downvotes: 3, buzz: 5, count: 100}
                  ]
              }

          ]
      }
    end

  end

  resource :list do
    desc "List all budget items matching query"
    params do
      requires :q, type: String
      optional :fields, type: String
      optional :size, type: Integer
      optional :from, type: Integer
    end
    get do
      result = search_client.search q: params[:q], sort: 'budget_total:desc'
      if params[:fields]
        result = search_client.search q: params[:q], fields: params[:fields], sort: 'budget_total:desc'
        hits = result['hits']
        items = hits['hits'].map { |hit| hit['fields']}
      else
        result = search_client.search q: params[:q], sort: 'budget_total:desc'
        hits = result['hits']
        items = hits['hits'].map { |hit| hit['_source'] }
      end
      { total: result['hits']['total'], result: items }
    end
  end

  resource :item do

  end
end
