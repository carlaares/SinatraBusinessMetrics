class BusinessMetrics < Sinatra::Base
  before do
    @flash = session.delete(:flash)
  end

  get '/' do
    erb :index
  end

  get '/graphs/:resource' do
    database_name = params[:resource]
    collection_name = 'counters.production.facebook.login_10'
    today_unix = Date.today.to_time.to_i
    start_week_unix = (Date.today - 7).to_time.to_i
    start_month_unix = (Date.today - 30).to_time.to_i

    @today_values = settings.mongo_connection.db(database_name)[collection_name].find( { :time => { :$gte => start_week_unix } } ).to_a
    #@week_values = settings.mongo_connection.db(database_name)[collection_name].find( { :time => { :$gte => start_week_unix } } ).to_a
    #@month_values = settings.mongo_connection.db(database_name)[collection_name].find( { :time => { :$gte => start_month_unix } } ).to_a

    collection_name = 'counters.production.publications.search_10'
    @publications_today_values = settings.mongo_connection.db(database_name)[collection_name].find( { :time => { :$gte => start_week_unix } } ).to_a

    erb :graphs
  end


  get '/test-flash' do
    session[:flash] = 'This is a flash'
    redirect to('/')
    erb :index
  end

end
