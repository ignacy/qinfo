require File.dirname(__FILE__) + "/helper"

qinfo = Helper.prepare_config

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
