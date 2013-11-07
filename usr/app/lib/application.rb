require 'sinatra/base'
require 'json'

class DeploymentsApp < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    deployments = Dir.foreach(ENV['OPENSHIFT_DEPLOYMENTS_DIR']).inject({}) { |result, f|
      next unless File.exists?(File.join(f, 'metadata.json'))
      result[File.basename(f)] = JSON::parse(File.read(File.join(f, 'metadata.json')))
      result
    }
    puts deployments.inspect
    erb :index, :locals => { :deployments => deployments }
  end

end
