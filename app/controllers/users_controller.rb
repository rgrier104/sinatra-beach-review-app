class UsersController < ApplicationController

  #the purpose of this route is to render the signup page
  get '/signup' do
    erb :'/signup'
  end

  #receive the signup form, create the user, and log the user in
  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id

    redirect "/users/#{@user.username}"
  end

  #the purpose of this route is to render the login page
  get '/login' do
    erb :'/login'
  end

  #receive the login form, find the user, and log the user in
  post '/login' do
    @user = User.find_by(username: params[:username])

    #authenticate password and confirm user has account in database
    if @user.authenticate(params[:password]) && user
      session[:user_id] = user.id
      redirect to "/users/#{:@user.username}"
    else
      redirect to "/login"
    end
  end

  get '/users/:username' do
    @user = User.find(session[:user_id])

    erb :'user/index'
  end

  get '/logout' do
    erb :'/user/logout'
  end

end
