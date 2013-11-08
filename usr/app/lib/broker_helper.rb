module BrokerHelper
  require 'fileutils'

  def broker
    user, password = Rack::Auth::Basic::Request.new(request.env).credentials
    RestClient::Resource.new(
      "https://#{ENV["OPENSHIFT_BROKER_HOST"]}/broker/rest",
      user, password,
    )
  end

  def application
    @broker_app ||= JSON::parse(
      broker["/domains/#{ENV['OPENSHIFT_NAMESPACE']}/applications/#{ENV['OPENSHIFT_APP_NAME']}"].get(http_headers)
    )
  end

  def deployments
    @deployments ||= JSON::parse(
      broker["/domains/#{ENV['OPENSHIFT_NAMESPACE']}/applications/#{ENV['OPENSHIFT_APP_NAME']}/deployments"].get(http_headers)
    )
  end

  def activate_deployment(deployment_id)
    prevent_restart do
      activate_json = {
        'event' => 'activate',
        'deployment_id' => deployment_id
      }
      activate_href = application['data']['links']['ACTIVATE']['href']
      activate_href.gsub!(/^http.*\/broker\/rest/, '')
      broker[activate_href].post(JSON::dump(activate_json), http_headers)
    end
  end

  private

  def prevent_restart(&block)
    lock_file = File.join(ENV['OPENSHIFT_DEPLOYMANAGER_DIR'], 'data', '.prevent_restart')
    File.write(lock_file, '')
    begin
      yield
    rescue => e
      raise e
    ensure
      FileUtils.rm_f(lock_file)
    end
  end

  def http_headers
    {
      :content_type => 'application/json',
      :accept => 'application/json'
    }
  end

end
