require 'sinatra/base'
require 'json'
require_relative './deployments_helper'

class DeploymentsApp < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  helpers DeploymentsHelper

  get '/' do
    erb :index
  end

end
