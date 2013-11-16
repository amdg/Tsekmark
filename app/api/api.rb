require 'grape'
class API < Grape::API

  prefix "api"
  version 'v1', :using => :path

  namespace :info do
    desc "Provides information about the API"
    get do
      { api:"Tsekmark API", version: version }
    end
  end

end
