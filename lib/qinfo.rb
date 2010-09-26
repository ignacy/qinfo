require 'rubygems'
require 'mysql2'
require 'benchmark'
require File.dirname(__FILE__) + "/qinfo/show_status"
require File.dirname(__FILE__) + "/qinfo/report"

class Qinfo
  attr_accessor :user, :password, :base, :connection, :before_status, :after_status
  
  def initialize(user, password, base)
    @user, @password, @base = user, password, base
    @connection = Mysql2::Client.new(:host => "localhost", :username => @user, :password => @password, :database => @base)
  end

  def execute(query)
    query = prepare_query(query)
    result = @connection.query(query)
    return result.each.inject([]) { |s, r| s << r.to_s }
  end

  def execute_straight(query)
    result = @connection.query(query)
    return result
  end

  def prepare_query(q)
    (q =~ /SQL_NO_CACHE/) ? q : q.sub!("SELECT", "SELECT SQL_NO_CACHE")
  end

  def benchmark_time_in_miliseconds(q)
    Benchmark.realtime { @connection.query(prepare_query(q)) } * 1000
  end

  def get_average_time_for_n_runs(n, q)
    runs = []
    n.times do 
      runs << benchmark_time_in_miliseconds(prepare_query(q))
    end
    average = runs.inject{ |sum, el| sum + el }.to_f / runs.size
  end

  def prepare_testing_enviroment
    @before_status = ShowStatus.new(self)
  end

  def get_results
    @after_status = ShowStatus.new(self)
  end

  def get_report
    Report.new @before_status, @after_status
  end

end

