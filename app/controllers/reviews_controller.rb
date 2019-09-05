require 'sinatra/base'
require 'rack-flash'

class ReviewsController < ApplicationController

  enable :sessions
  use Rack::Flash

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
    #find user
    @user = User.find(session[:user_id])

    #create new review
    @review = Review.create(params[:review])

    #add beach or create new beach

    if !!params[:beach][:name] && !!params[:beach][:id]
      #show error message if user tries to select a beach and create a new beach
      flash[:message] = "You cannot have a beach selected and create a new beach. Please choose one."
      redirect "reviews/new"

    elsif  !!params[:beach][:name] && !params[:beach][:id]
      #create new beach if id is empty and name is filled out
      #add review to new beach and user
      @beach = Beach.create(params[:beach])
      @beach.reviews << @review
      @user.reviews << @review

    elsif !!params[:beach][:id]
      #find existing beach and add review
      @beach = Beach.find(params[:beach][:id])
      @beach.reviews << @review
      @user.reviews << @review
    else
      #error message
      redirect "/reviews/new"
    end

    redirect "/beaches/#{@beach.slug}"

  end

  #route to edit review
  get '/reviews/:id/edit' do
    @review = Review.find(params[:id])

    erb :"/reviews/edit"
  end

  #edit review
  patch '/reviews/:id' do
    #find review
    @review = Review.find(params[:id])
    #update review
    @review.update(params[:review])

    redirect "/reviews"
  end


end
