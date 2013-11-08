module BrokerHelper

  def broker
    user, password = Rack::Auth::Basic::Request.new(request.env).credentials
    RestClient::Resource.new(
      "https://#{ENV["OPENSHIFT_BROKER_HOST"]}/broker/rest",
      user, password,
    )
  end

  def broker_application
    @broker_app ||= JSON::parse(broker["/domains/#{ENV['OPENSHIFT_NAMESPACE']}/applications/#{ENV['OPENSHIFT_APP_NAME=']}"].get)
  end

end
