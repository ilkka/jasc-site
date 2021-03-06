PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

Spec::Runner.configure do |conf|
  conf.mock_with :mocha
  conf.include Rack::Test::Methods
  conf.include Shoulda::ActiveRecord::Matchers
end

def app
  ##
  # You can hanlde all padrino applications using instead:
  #   Padrino.application
  Jasc.tap { |app|  }
end
