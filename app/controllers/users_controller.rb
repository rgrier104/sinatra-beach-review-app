class UsersController < ApplicationController

  #the purpose of this route is to render the signup page
  get '/signup' do
    erb :'/signup'
  end

  #receive the signup form, check if user already has account,
  # create the user, and log the user in
  post '/signup' do
    existing_user = User.find_by(username: params[:username], email: params[:email])

    if !existing_user
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id

      redirect "/users/#{@user.username}"
    else
      redirect "/login"
      #maybe try to add error message
    end
  end

  #the purpose of this route is to render the login page
  get '/login' do
    erb :'/login'
  end

  #receive the login form, find the user, and log the user in
  post '/login' do
    @user = User.find_by(email: params[:email])

    #authenticate password and confirm user has account in database
    if @user.authenticate(params[:password]) && @user
      session[:user_id] = @user.id
      redirect to "/users/#{@user.username}"
    else
      redirect to "/login"
    end
  end

  get '/users/:username' do
    @user = User.find(session[:user_id])
    binding.pry
    erb :'users/show'
  end

  get '/logout' do
    # if logged_in?
      session.clear
      redirect "/login"
    # else
    #   redirect "/"
    # end
    erb :'/users/logout'
  end

end
