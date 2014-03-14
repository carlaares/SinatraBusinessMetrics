require 'sinatra/base'
require_relative 'routes/init'
require_relative 'helpers/init'
require_relative 'models/init'

require 'mongo'
require 'json/ext' # required for .to_json

include Mongo

class BusinessMetrics < Sinatra::Base
  enable :method_override
  enable :sessions
  set :session_secret, 'super secret'


  configure do
    conn = MongoClient.new("192.168.0.11")
    set :mongo_connection, conn
    set :mongo_db, conn.db('business-metrics')
    set :logging, :true
    set :app_file, __FILE__
  end

  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :qa do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false #false will show nicer error page
    set :show_exceptions, false #true will ignore raise_errors and display backtrace in browser
  end
end
