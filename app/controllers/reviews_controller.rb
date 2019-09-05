class ReviewsController < ApplicationController

  #route to render reviews index
  get '/reviews' do

    erb :"/reviews/index"
  end

  #route to render new review form
  get '/reviews/new' do

    erb :"/reviews/new"
  end

  #take new review params to create review/beach
  post '/reviews' do

    #create new review
    @review = Review.create(params[:review])

    #add beach or create new beach
    #create new beach if id is empty and name is filled out
    #add review to new beach
    if !!params[:beach][:name] && !params[:beach][:id]
      @beach = Beach.create(params[:beach])
      @beach.reviews << @review
    elsif !!params[:beach][:id]
      #find existing beach and add review
      @beach = Beach.find(params[:beach][:id])
      @beach.reviews << @review
    else
      #error message
      redirect "/reviews/new"
    end

    redirect "/reviews/#{@beach.slug}"

  end



end
