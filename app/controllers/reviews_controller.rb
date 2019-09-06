require 'sinatra/base'
require 'rack-flash'

class ReviewsController < ApplicationController

  enable :sessions
  use Rack::Flash

  #route to render reviews index
  get '/reviews' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :"/reviews/index"
    else
      flash[:message] = "You must be logged in to view reviews."
      erb :"/login"
    end
  end

  #route to render new review form
  get '/reviews/new' do
    if logged_in?
      erb :"/reviews/new"
    else
      flash[:message] = "You must be logged in to create reviews."
      erb :"/login"
    end
  end

  #take new review params to create review/beach
  post '/reviews' do
    #find user
    @user = User.find(session[:user_id])

    #add beach or create new beach

    #show error message if user tries to select a beach and create a new beach
    if params[:beach][:name] != "" && !!params[:beach][:id]
      flash[:message] = "You cannot have a beach selected and create a new beach. Please choose one."
      redirect "/reviews/new"

    #ensure new beach does not already exist;
  elsif !!Beach.find_by_slug(params[:beach][:name].downcase.gsub(' ','-'))
      flash[:message] = "This beach already exists. Please select in list."
      redirect "/reviews/new"

    #if rating is blank show error
    elsif !params[:review][:rating]
      flash[:message] = "Please enter rating."
      redirect "/reviews/new"

    #create new beach if id is empty and name is filled out
    elsif  params[:beach][:name] != "" && !params[:beach][:id]

      #ensure shore and city are filled out
        if params[:beach][:shore] == "" || params[:beach][:city] == ""

          flash[:message] = "Please enter shore and city to continue."
          redirect "/reviews/new"
        else
          #create new review
          @review = Review.create(params[:review])
          #create new beach
          @beach = Beach.create(params[:beach])
          #add review to new beach and user
          @beach.reviews << @review
          @user.reviews << @review
        end
    #if existing beach is selected
    elsif !!params[:beach][:id]
      #create new review
      @review = Review.create(params[:review])
      #find beach
      @beach = Beach.find(params[:beach][:id])
      #add review to beach and user
      @beach.reviews << @review
      @user.reviews << @review
    else
      #error if the criteria above aren't met
      flash[:message] = "Please ensure form fields are filled out correctly."
      redirect "/reviews/new"
    end
    #go to review show page

    redirect "/reviews/#{@review.id}"

  end

  #route to review show page
  get '/reviews/:id' do
    if logged_in?
      @review = Review.find(params[:id])
      @user = current_user
      erb :"/reviews/show"
    else
      flash[:message] = "You must be logged in to view reviews."
      erb :"/login"
    end
  end

  #route to edit review
  get '/reviews/:id/edit' do

    @review = Review.find(params[:id])
    @user = current_user
binding.pry
    if logged_in? && current_user.id == @review.user_id
      erb :"/reviews/edit"
    elsif logged_in?
      flash[:message] = "You cannot edit reviews you did not create."
      erb :"/reviews/show"
    else
      flash[:message] = "You must be logged in to edit reviews."
      erb :"/login"
    end
  end


  #edit review
  patch '/reviews/:id' do
    #find review
    @review = Review.find(params[:id])
    #update review
    @review.update(params[:review])

    redirect "/reviews/#{@review.id}"
  end

  delete '/reviews/:id' do
    #find review
    review = Review.find(params[:id])
    #only let user delete review if they created it
    if review.user_id == session[:user_id]
      review.destroy
      redirect "/reviews"
    else
      flash[:message] = "You cannot delete a review you did not write."
      redirect "/reviews/#{review.id}"
    end
  end


end
