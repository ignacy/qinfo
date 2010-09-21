require 'rubygems'
require 'mysql2'
require 'yaml'

def get_connection
  config_file = File.dirname(__FILE__) + '/../config.yml'
  config = YAML::parse( File.open(File.expand_path(config_file)))
  user = config["user"].value
  password = config["password"].value
  database = config["base"].value
  Qinfo.new(user, password, database)
end

