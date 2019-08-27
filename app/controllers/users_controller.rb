class UsersController < ApplicationController

  #the purpose of this route is to render  the signup page
  get '/signup' do
    erb :'/signup'
  end

  get '/login' do
    erb :'/login'
  end

  get '/logout' do
    erb :'/user/logout'
  end

end
