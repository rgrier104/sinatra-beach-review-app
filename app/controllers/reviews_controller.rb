
class ReviewsController < ApplicationController

  enable :sessions
  use Rack::Flash

  #route to render reviews index
  get '/reviews' do
    if logged_in?
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
    if params[:beach][:name] != "" && params[:beach][:id] != ""
      #show error message if user tries to select a beach and create a new beach
      flash[:message] = "You cannot have a beach selected and create a new beach. Please choose one."
      redirect "/reviews/new"

    elsif  params[:beach][:name] != "" && params[:beach][:id] == ""
      #create new beach if id is empty and name is filled out
      #add review to new beach and user
      #create new review
      @review = Review.create(params[:review])
      @beach = Beach.create(params[:beach])
      @beach.reviews << @review
      @user.reviews << @review

    elsif params[:beach][:id] != ""
      #find existing beach and add review
      #create new review
      @review = Review.create(params[:review])
      @beach = Beach.find(params[:beach][:id])
      @beach.reviews << @review
      @user.reviews << @review
    else
      #error message
      redirect "/reviews/new"
    end

    redirect "/reviews/#{@review.id}"

  end

  #route to review show page
  get '/reviews/:id' do
    if logged_in?
      @review = Review.find(params[:id])

      erb :"/reviews/show"
    else
      flash[:message] = "You must be logged in to view reviews."
      erb :"/login"
    end
  end

  #route to edit review
  get '/reviews/:id/edit' do
    if logged_in?
      @review = Review.find(params[:id])

      erb :"/reviews/edit"
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
