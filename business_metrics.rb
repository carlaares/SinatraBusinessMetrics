require 'sinatra'
require 'sinatra/reloader'

require 'mongo'
require 'json/ext' # required for .to_json

include Mongo

configure do
  conn = MongoClient.new("192.168.0.11")
  set :mongo_connection, conn
  set :mongo_db, conn.db('business-metrics')
end


get '/' do
  erb :index
end

get '/resources' do
  @resources = settings.mongo_db['resources'].find.to_a
  erb :resources
end

