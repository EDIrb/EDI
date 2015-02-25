$: << File.expand_path('../', __FILE__)
require 'jarvis'
Jarvis.configure { |config| config.root = File.dirname(__FILE__) }
Jarvis.bootstrap
run Server
