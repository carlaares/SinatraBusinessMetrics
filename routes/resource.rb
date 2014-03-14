class BusinessMetrics < Sinatra::Base
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
    settings.mongo_db['resources'].remove(:_id => mongo_object_id(params[:id]))
    redirect to('/resources')
  end
end