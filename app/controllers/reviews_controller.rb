class ReviewsController < ApplicationController

  #route to render reviews index
  get '/reviews' do

    erb :"/reviews/index"
  end

  #route to render new review form
  get '/revews/new' do
    
    erb :"/reviews/new"
  end


end
