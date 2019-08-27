class UsersController < ApplicationController

  #the purpose of this route is to render  the signup page
  get '/signup' do
    erb :'/signup'
  end

  get '/login' do
    erb :'/login'
  end

  #receive the login form, find the user, and log the user in
  post '/login' do
    @user = User.find_by(username: params[:username])

    #authenticate password and
    if @user.authenticate(params[:password]) && user
      session[:user_id] = user.id
      redirect to "/user/index"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    erb :'/user/logout'
  end

end
