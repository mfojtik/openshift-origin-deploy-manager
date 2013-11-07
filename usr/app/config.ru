load './lib/application.rb'

use Rack::Static, :urls => ["/images", "/js", "/css"], :root => "public"
run DeploymentsApp
