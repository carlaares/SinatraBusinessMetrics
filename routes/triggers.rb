class BusinessMetrics < Sinatra::Base
  get '/triggers' do
    @triggers = settings.mongo_db['triggers'].find.to_a
    erb :triggers
  end

  post '/triggers' do
    p = {}
    [ :name, :execute_every, :trigger_if, :threshold_warning, :threshold_error, :resource ].each do |attribute|
      p[attribute] = params[attribute]
    end
    new_id = settings.mongo_db['triggers'].insert p
    redirect to('/triggers')
  end

  delete '/triggers/:id' do
    settings.mongo_db['triggers'].remove(:_id => mongo_object_id(params[:id]))
    redirect to('/triggers')
  end
end