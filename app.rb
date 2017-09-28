require("bundler/setup")
require "pry"
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
enable :sessions

before do
  @user = session[:id]
end

get('/') do
  erb(:index)
end

post('/login') do
  session[:id] = params.fetch("username")
  password = params.fetch("password")
  redirect '/'
end

post('/logout') do
  session.clear
  redirect '/'
end

get('/trains') do
  @trains = Train.all
  erb(:trains)
end

post('/add-train') do
  train = Train.new({name: params.fetch("name")})
  if train.save
    redirect '/trains'
  else
    @error_type = train
    erb(:errors)
  end
end

get('/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @cities = City.all
  erb(:train)
end

get('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i)
  erb(:train_edit)
end

patch("/trains/:id/edit") do
  @train = Train.find(params[:id].to_i)
  if @train.update({name: params.fetch("name")})
    redirect '/trains/' + @train.id.to_s
  else
    @error_type = @train
    erb(:errors)
  end
end

delete("/trains/:id/delete") do
  @train = Train.find(params[:id].to_i)
  if @train.delete
    redirect '/trains'
  else
    @error_type = @train
    erb(:errors)
  end
end

get('/cities') do
  @cities = City.all
  erb(:cities)
end

post('/add-city') do
  @city = City.new({name: params['name']})
  if @city.save
    redirect '/cities'
  else
    @error_type = @city
    erb(:errors)
  end
end

get('/cities/:id') do
  @trains = Train.all
  @city = City.find(params[:id].to_i)
  erb(:city)
end

get('/cities/:id/edit') do
  @city = City.find(params[:id].to_i)
  erb(:city_edit)
end

patch('/cities/:id/edit') do
  @city = City.find(params[:id].to_i)
  if @city.update({name: params['name']})
    redirect '/cities/' + @city.id.to_s
  else
    @error_type = @city
    erb(:errors)
  end
end

delete('/cities/:id/delete') do
  @city = City.find(params[:id].to_i)
  if @city.delete
    redirect '/cities'
  else
    @error_type = @city
    erb(:errors)
  end
end

post('/add-stop') do
  @stop = Stop.new({
    departure: Time.parse(params['departure']),
    city_id: params['city'].to_i,
    train_id: params['train'].to_i
  })
  if @stop.save
    redirect '/stops/' + @stop.id.to_s
  else
    @error_type = @stop
    erb(:errors)
  end
end

get ('/stops/:id') do
  @stop = Stop.find(params[:id].to_i)
  erb(:stop)
end

get ('/stops/:id/edit') do
  @stop = Stop.find(params[:id].to_i)
  erb(:stop_edit)
end

patch ('/stops/:id/edit') do
  @stop = Stop.find(params[:id].to_i)
  if @stop.update({depature: Time.parse(params['departure'])})
    redirect '/stops/' + @stop.id.to_s
  else
    @error_type = @stop
    erb(:errors)
  end
end

delete('/stops/:id/delete') do
  @stop = Stop.find(params[:id].to_i)
  if @stop.delete
    redirect '/trains/' + @stop.train_id.to_s
  else
    @error_type = @stop
    erb(:errors)
  end
end

get('/tickets') do
  @trains = Train.all
  @tickets = Ticket.all
  if params["train"]
    @train = Train.find(params.fetch("train").to_i)
  end
  erb(:tickets)
end

post('/buy-ticket') do
  @ticket = Ticket.new({train_id: params.fetch("train").to_i, start_city_id: params.fetch("start_city").to_i, end_city_id: params.fetch("end_city").to_i})
  if @ticket.save
    redirect '/ticket-success/' + @ticket.id.to_s
  else
    @error_type = @ticket
    erb(:errors)
  end
end

get('/ticket-success/:id') do
  @ticket = Ticket.find(params[:id].to_i)
  erb(:ticket_success)
end
