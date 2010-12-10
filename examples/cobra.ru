# Example Cobra rackup config. Drop a cobra.ru file
# in your projects direct
require 'cobra'

# setup middleware
use Rack::CommonLogger

# configure cobra
Cobra::Server.configure do |config|
  config.set :project_path, File.dirname(__FILE__)
  config.set :show_exceptions, true
  config.set :lock, true
end

run Cobra::Server
