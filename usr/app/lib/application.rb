require 'sinatra/base'
require 'json'
require_relative './deployments_helper'
require_relative './broker_helper'
require 'time'

class DeploymentsApp < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  helpers DeploymentsHelper
  helpers BrokerHelper

  get '/' do
    erb :index
  end

end
