require_relative "application_controller"
# User Controller
class ApplicationController < Sinatra::Base
	
    get '/signup' do
        unless session[:user_id]
            erb :signup
        else
            redirect "/", :notice => "You have to logout before signing up for a new user!"
        end
    end
    
    post '/signup' do
        user = User.new(username: params[:username])
        user.password = params[:password]
        
        if user.save
            session[:user_id] = user.id
            redirect "/search"
        else
            redirect "/signup", :notice => "Signing up didn't work, try again!"
        end
    end
    
    get '/login' do
        unless session[:user_id]
            erb :login
        else
            redirect "/", :notice => "You have to logout before logging in again!"
        end
    end
    
    post '/login' do
        # Searches the database to find a user with the same username
        user = User.find_by(username: params[:username])
        # Checks to see if the user exists AND if the user has the same password
        #    If it succeeds, then a session with the user's id will be created
        #    Otherwise, it will redirect back to the default page
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/"
        end
        redirect "/", :notice => "Something went wrong while logging in, try again!"
    end
    
    get '/logout' do
        session[:user_id] = nil
        redirect "/"
    end
    
    get '/user/:id' do
        "USER/#{params[:id]}"
    end
end