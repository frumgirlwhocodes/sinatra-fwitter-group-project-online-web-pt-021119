    
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "frumgirl"
  end

  

 helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

    end

    def is_logged_in?
      !!current_user
    end
  end
end
