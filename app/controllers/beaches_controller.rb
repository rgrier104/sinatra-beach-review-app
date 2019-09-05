class BeachesController < ApplicationController
  enable :sessions
  use Rack::Flash

  #render beaches index page
  get '/beaches' do
    if logged_in?
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

      erb :'/beaches/show'
    else
      flash[:message] = "You must be logged in to view reviews."
      erb :"/login"
    end
  end


end
