require 'rubygems'
require 'test/unit'

ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'cobra'

Cobra::Server.set :project_path, "."
Cobra::Server.set :environment,  "test"

class Test::Unit::TestCase
end
