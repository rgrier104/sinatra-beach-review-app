class UsersController < ApplicationController
  enable :sessions
  use Rack::Flash

  #the purpose of this route is to render the signup page
  get '/signup' do
    erb :'/signup'
  end

  #receive the signup form, check if user already has account,
  # create the user, and log the user in
  post '/signup' do
    existing_username = User.find_by(username: params[:username])
    existing_email = User.find_by(email: params[:email])

    if !existing_username && !existing_email
      #if there is not a user with that email or username create new user
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id

      redirect "/users/#{@user.username}"
    elsif existing_username && !existing_email
      #if there is already a user with that username then have them change username
      flash[:message] = "That username is already taken. Please use a different username."
      redirect "/signup"
    else
      flash[:message] = "It looks like you already have an account with that email. Please login."
      redirect "/login"

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
      flash[:message] = "Your email and password combination is not correct."
      redirect to "/login"
    end
  end

  get '/users/:username' do
    if logged_in?
      @user = User.find(session[:user_id])

      erb :'users/index'
    else
      flash[:message] = "You must be logged in to view user reviews."
      erb :"/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end
    erb :'/users/logout'
  end

end
