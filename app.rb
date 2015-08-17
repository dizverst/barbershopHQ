require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Barbers < ActiveRecord::Base

end

class Clients < ActiveRecord::Base

end

before do
	@barbers = Barbers.all
end

get '/' do
	@barbers = Barbers.order "created_at DESC"
	erb :index	
end

get '/visit' do

	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone    = params[:phone]
	@datetime = params[:datetime]
	@barberopt = params[:barberopt]
	@color = params[:color]	

	hh = {  
			:username => "Вы не ввели имя!",
			:phone => "Вы не ввели телефон!", 
			:datetime => "Вы не ввели дату и время!"
		}

	@error = hh.select { |key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visit
	end

	c = Clients.new
	c.name = @username
	c.phone = @phone
	c.datestamp = @datetime
	c.barber = @barberopt
	c.color = @color
	c.save


  	erb "<h2>Вы записаны!</h2>"
end

get '/contacts' do
  	erb :contacts
end