require 'sinatra'
require 'json'
require './fare_calculator'
require './price_class'
#class Server < Sinatra::Base
	get '/' do
	  'hello'
	end
	
	post '/calculate' do
	  fare_calc=FareCalculator.new(PriceClass.new({1..2=>1.48, 3..4=>1.78, 5..6=>1.92, 7..10=>2.07}))
	  data = JSON.parse request.body.read
	  fare_calc.passengers = data['passengers']
	  result = fare_calc.calculate(data['distance'])
	  content_type :json
  	{:price=> result}.to_json
  end
#end