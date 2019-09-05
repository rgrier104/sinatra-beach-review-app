class BeachesController < ApplicationController

  #render beaches index page
  get '/beaches' do

    erb :'/beaches/index'
  end

  #render show page that lists beach reviews for specified beach
  get '/beaches/:slug' do
    @beach = Beach.find_by_slug(params[:slug])

    erb :'/beaches/show'
  end


end
