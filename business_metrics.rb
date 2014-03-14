require 'sinatra'
require 'sinatra/reloader'

require 'mongo'
require 'json/ext' # required for .to_json

include Mongo

use Rack::MethodOverride

configure do
  conn = MongoClient.new("192.168.0.11")
  set :mongo_connection, conn
  set :mongo_db, conn.db('business-metrics')
  set :logging, :true
end

get '/' do
  erb :index
end

get '/resources' do
  @resources = settings.mongo_db['resources'].find.to_a
  erb :resources
end

post '/resources' do
  p = { name: params[:name] }
  new_id = settings.mongo_db['resources'].insert p
  redirect to('/resources')
end

delete '/resources/:id' do
  settings.mongo_db['resources'].remove(:_id => object_id(params[:id]))
  redirect to('/resources')
end

get '/graphs' do
  erb :graphs
end


helpers do
  # a helper method to turn a string ID
  # representation into a BSON::ObjectId
  def object_id val
    BSON::ObjectId.from_string(val)
  end

  def document_by_id id
    id = object_id(id) if String === id
    settings.mongo_db['test'].
      find_one(:_id => id).to_json
  end
end