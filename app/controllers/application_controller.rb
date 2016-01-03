require "require_all" 
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'pry'

require_relative "../../config/environment"
require_all "app/models/*.rb"
require_all "app/controllers/*.rb"

class ApplicationController < Sinatra::Base
    register Sinatra::Flash
    helpers Sinatra::RedirectWithFlash
    
	enable :sessions
    set :session_secret, "banana"

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'

		Tmdb::Api.key("9700bb0192b8a83fb4c9e8890ee34f15")
		CONFIG = Tmdb::Configuration.new
	end

	get "/" do
        erb :header
	end
  
end
