class UsersController < ApplicationController

  get '/signup' do
    erb :'/user/signup'
  end

  get '/login' do
    erb :'/user/login'
  end

  get '/logout' do
    erb :'/user/logout'
  end

end
