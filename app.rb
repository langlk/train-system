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
