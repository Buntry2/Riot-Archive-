require "require_all" 
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require "sinatra/json"
require 'pry'
require 'lol'

require_relative "../../config/environment"
require_all "app/models/*.rb"
require_all "app/controllers/*.rb"

class ApplicationController < Sinatra::Base
    register Sinatra::Flash
    helpers Sinatra::RedirectWithFlash
    
	enable :sessions
    set :session_secret, "banana"

	LC = Lol::Client.new "017516d9-10e6-4637-bb23-81f8f5cd9397", {region: "na", cached: true}
	ID = 36759700
	
	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
	end
  
	get "/" do
        redirect "/ranked"
	end
	
end
