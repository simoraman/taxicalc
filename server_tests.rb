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
    assert_equal(20.5, result['price'])
  end
  def test_calculate_from_string_params
    post '/calculate', {:distance=>"10", :passengers=>"2"}.to_json, "CONTENT_TYPE" => "application/json"
    result = JSON.parse(last_response.body)
    assert_equal(20.5, result['price'])
  end
  def test_empty_params_should_return_error
    post '/calculate', {:distance=>"", :passengers=>""}.to_json, "CONTENT_TYPE" => "application/json"  
    assert last_response.ok?
  end
  def test_missing_params_should_not_fail
    assert_nothing_raised do
     post '/calculate', {:passengers=>"1"}.to_json, "CONTENT_TYPE" => "application/json"  
    end
  end
end