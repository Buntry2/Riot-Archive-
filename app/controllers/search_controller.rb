require_relative "application_controller"
# Search Controller
class ApplicationController < Sinatra::Base
	
	get '/search' do
        erb :header
	end
	
	post '/search' do
		@movies = []
		Tmdb::Movie.find(params[:query]).first(24).each do |movie|
			@movies << Tmdb::Movie.detail(movie.id)
		end
		erb :"movies/index"
  	end
	
	get '/now_playing' do
		@movies = Tmdb::Movie.now_playing.first(24)
		
		erb :"movies/index"
	end
	
	get '/popular' do
		@movies = Tmdb::Movie.popular.first(24)
		
		erb :"movies/index"
	end
	
	get '/upcoming' do
		@movies = Tmdb::Movie.upcoming.first(24)
		
		erb :"movies/index"
	end
	
	get '/top_rated' do
		@movies = Tmdb::Movie.top_rated.first(24)
		
		erb :"movies/index"
	end
end