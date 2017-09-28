require("bundler/setup")
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
    erb(:errors)
  end
end

get('/trains/:id') do
  @train = Train.find(params[:id].to_i)
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
    erb(:errors)
  end
end

delete("/trains/:id/delete") do
  @train = Train.find(params[:id].to_i)
  if @train.delete
    redirect '/trains'
  else
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
    erb(:errors)
  end
end

get('/cities/:id') do
  @city = City.find(params[:id].to_i)
  erb(:city)
end
