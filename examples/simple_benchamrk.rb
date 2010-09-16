require File.dirname(__FILE__) + "/../lib/qinfo"
require 'yaml'


module SimpleBenchmark
  
  def SimpleBenchmark.prepare_config
    config_file = File.dirname(__FILE__) + '/../config.yml'
    config = YAML::parse( File.open(File.expand_path(config_file)))
    user = config["user"].value
    password = config["password"].value
    database = config["base"].value
    return Qinfo.new(user, password, database)
  end
end

qinfo = SimpleBenchmark.prepare_config

q1 = "SELECT * FROM accounts"
q2 = "SELECT id FROM accounts"

result1 = qinfo.benchmark_time_in_miliseconds(q1)
result2 = qinfo.benchmark_time_in_miliseconds(q2)

puts "Reults: \n"

puts "Query:   #{q1} \n"
puts "Time taken: #{result1} \n"

puts "Query:   #{q2} \n"
puts "Time taken: #{result2} \n"

diff = result1 - result2

faster = (diff > 0) ? q2 : q1

puts "Query: #{faster} was faster by #{diff.abs}"
