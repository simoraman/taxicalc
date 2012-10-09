require 'rubygems'
require 'sinatra'
require 'test/unit'
require 'rack/test'
require './taxicalc_server'
require 'json'
ENV['RACK_ENV'] = 'test'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

	def app
		#Server.new
		Sinatra::Application
	end

  def test_root_is_accessible
    get '/'
    assert last_response.ok?
  end
  
  def test_calculate_takes_distance_and_passenger_count
    post '/calculate', {:distance=>10, :passengers=>2}.to_json, "CONTENT_TYPE" => "application/json"
    result = JSON.parse(last_response.body)
    assert_equal(14.8, result['price'])
  end
end