require 'rubygems'
require 'rest-client'

load './lib/application.rb'

use Rack::Static, :urls => ["/images", "/js", "/css"], :root => "public"
use Rack::Auth::Basic, "Deployment Manager authentication" do |username, password|
  response = RestClient::Request.new(
    :method => :get,
    :url => "https://#{ENV['OPENSHIFT_BROKER_HOST']}/broker/rest/user",
    :user => username,
    :password => password,
    :headers => { :accept => :json, :content_type => :json }
  ).execute
  response.code == 200
end

run DeploymentsApp
