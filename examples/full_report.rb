require File.dirname(__FILE__) + "/helper"
qinfo = Helper.prepare_config

q = "SELECT id FROM accounts"
time = qinfo.get_average_time_for_n_runs(20, q)

# I'm using algorithm proposed by one of the authors of:
# http://www.amazon.com/High-Performance-MySQL-Optimization-Replication/dp/0596101716

# 1. Run the query a few times to "warm up" the server
10.times do 
  qinfo.execute_straight(q)
end

# 2. Run "SHOW STATUS" and save the results
qinfo.prepare_testing_enviroment

# 3. Run profiled query
qinfo.execute(q)

# 4. Run "Show STATUS" again
qinfo.get_results

# 5. Compare "SHOW STATUS" runs
report = qinfo.get_report

puts "This query has taken aprox. #{time} seconds"

puts "HTML:"
report.to_html

puts "String:"
report.to_string

