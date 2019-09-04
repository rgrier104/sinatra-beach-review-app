class ReviewsController < ApplicationController

  #route to render reviews index
  get '/reviews' do

    erb :"/reviews/index"
  end


end
