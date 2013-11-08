module BrokerHelper

  def broker
    RestClient::Resource.new(
      "https://#{ENV["OPENSHIFT_BROKER_HOST"]}/broker/rest",
      :headers => {
        :http_authorization => request.env['HTTP_AUTHORIZATION'],
        :accept => 'application/json'
      }
    )
  end

  def broker_application
    @broker_app ||= JSON::parse(broker["/domains/#{ENV['OPENSHIFT_NAMESPACE']}/applications/#{ENV['OPENSHIFT_APP_NAME=']}"].get)
  end

end
