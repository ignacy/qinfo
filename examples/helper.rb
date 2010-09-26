require File.dirname(__FILE__) + "/../lib/qinfo"
require 'yaml'


module Helper
  def Helper.prepare_config
    config_file = File.dirname(__FILE__) + '/../config.yml'
    config = YAML::parse( File.open(File.expand_path(config_file)))
    user = config["user"].value
    password = config["password"].value
    database = config["base"].value
    return Qinfo.new(user, password, database)
  end
end

