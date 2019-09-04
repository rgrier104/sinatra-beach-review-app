class ReviewsController < ApplicationController

  #route to render reviews index
  get '/reviews' do

    erb :"/reviews/index"
  end

  #route to render new review form
  get '/reviews/new' do

    erb :"/reviews/new"
  end


end
