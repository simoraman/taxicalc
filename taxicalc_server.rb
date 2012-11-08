require 'sinatra'
require 'json'
require_relative 'fare_calculator'
require_relative 'price_class'

set :public_folder, File.dirname(__FILE__) + '/front'
get '/' do
  send_file File.join(settings.public_folder, 'main.html')
end

post '/calculate' do
  fare_calc=FareCalculator.new(PriceClass.new({1..2=>1.48, 3..4=>1.78, 5..6=>1.92, 7..10=>2.07}))
  begin
    data = JSON.parse request.body.read
    passengers=data['passengers'].to_f
    distance=data['distance'].to_f
  rescue
    puts 'err'
    return {:error=>'malformed json'}.to_json
  end
  fare_calc.passengers = passengers
  result = fare_calc.calculate(distance)
  content_type :json
  {:price=> result}.to_json
end
