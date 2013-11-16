require 'grape'
require 'grape-swagger'
require 'rack/cors'

class Base < Grape::API
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => :any
    end
  end

  rescue_from :all, :backtrace => false do |e|
    Base.send_error_response(e)
  end
  format :json
  default_format :json

  helpers APIHelpers
  mount API
  mount Users::API
  mount Votes::API
  mount Gas::API
  mount Summary::API

  add_swagger_documentation markdown: true, api_version: "v1", hide_documentation_path: true

  #if Rails.env.production?
  #  extend NewRelic::Agent::Instrumentation::Rack
  #end

  private

    def self.send_error_response(e)
      case e
      when ActiveRecord::RecordNotFound
        status = 404
        msg = 'Not Found'
      when ArgumentError
        status = 400
        msg = 'Not Found'
      else
        status = 500
        msg = 'Internal Server Error. Check your parameters.'
      end
      msg << " -- EXCEPTION MSG: #{e.message}"
      ap msg
      Rack::Response.new({
         'status' => status,
         'message' => msg
       }.to_json, status)
    end
end
