require_relative "application_controller"
# Day Controller
class ApplicationController < Sinatra::Base
    
    get '/progress' do
        @days = Day.all
        erb :"days/index"
    end
    
end