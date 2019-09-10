require 'sinatra/base'
require 'sinatra/flash'

class BeachesController < ApplicationController
  enable :sessions
  register Sinatra::Flash

  #render beaches index page
  get '/beaches' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'/beaches/index'
    else
      flash[:message] = "You must be logged in to view beaches."
      erb :"/login"
    end
  end

  #render show page that lists beach reviews for specified beach
  get '/beaches/:slug' do
    if logged_in?
      @beach = Beach.find_by_slug(params[:slug])
      @user = User.find(session[:user_id])
      erb :'/beaches/show'
    else
      flash[:message] = "You must be logged in to view reviews."
      erb :"/login"
    end
  end


end
