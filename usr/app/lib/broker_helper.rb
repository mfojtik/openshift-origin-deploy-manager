module BrokerHelper

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
    activate_json = {
      'event' => 'activate',
      'deployment_id' => deployment_id
    }
    activate_href = application['data']['links']['ACTIVATE']['href']
    activate_href.gsub!(/^http.*\/broker\/rest/, '')
    broker[activate_href].post(JSON::dump(activate_json), http_headers)
  end

  private

  def http_headers
    {
      :content_type => 'application/json',
      :accept => 'application/json'
    }
  end

end
