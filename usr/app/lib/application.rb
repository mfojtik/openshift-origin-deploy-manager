require 'sinatra/base'
require 'json'

class DeploymentsApp < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')

  helpers do

    def deployments
      Dir.glob(ENV['OPENSHIFT_DEPLOYMENTS_DIR'] + '*').reject { |f|
        File.basename(f) !~ /^(\d{4})\-/ || !File.exists?(File.join(f, 'metadata.json'))
      }.inject({}) { |result, f|
        result[File.basename(f)] = JSON::parse(File.read(File.join(f, 'metadata.json')))
        result
      }
    end

  end

  get '/' do
    erb :index
  end

end
