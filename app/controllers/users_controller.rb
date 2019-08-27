class UsersController < Sinatra::Base

  get '/signup' do
    erb :signup
  end

  get '/login' do
    erb :login
  end

  get '/logout' do
    erb :logout
  end

end
