require 'sinatra/base'
require_relative 'routes/init'
require_relative 'helpers/init'
require_relative 'models/init'

require 'mongo'
require 'json/ext' # required for .to_json
require 'statsd-instrument'

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


# The UDP endpoint to which you want to submit your metrics.
# This is set to the environment variable STATSD_ADDR if it is set.
StatsD.server = '192.168.0.11:8125' 

# Events are only actually submitted in production mode. For any other value, thewy are logged instead
# This value is set by to the value of the RAILS_ENV or RACK_ENV environment variable if it is set.
# StatsD.mode = :production

# Logger to which commands are logged when not in :production mode.
# In  production only errors are logged to the console.
#StatsD.logger = Rails.logger

# An optional prefix to be added to each stat.
StatsD.prefix = 'business_metrics_stats' 

# Sample 10% of events. By default all events are reported, which may overload your network or server.
# You can, and should vary this on a per metric basis, depending on frequency and accuracy requirements
StatsD.default_sample_rate = 0.1 