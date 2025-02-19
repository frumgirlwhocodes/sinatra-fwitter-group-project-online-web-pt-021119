
class UsersController < ApplicationController

  get '/signup' do
    if !is_logged_in?  
      erb :'/users/create_user'
    else
    redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if is_logged_in?  
      redirect to '/tweets'
    end

    erb :"/users/login"
  end

  post '/login' do
    user = User.find_by(:username => params["username"])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end


  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"/users/show"
  end

  get '/logout' do
    if is_logged_in?  
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end