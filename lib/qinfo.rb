require 'rubygems'
require 'mysql2'
require 'benchmark'

class Qinfo
  attr_accessor :user, :password, :base, :qonection
  
  def initialize(user, password, base)
    @user, @password, @base = user, password, base
    @qonection = Mysql2::Client.new(:host => "localhost", :username => @user, :password => @password, :database => @base)
  end

  def execute(query)
    query = prepare_query(query)
    result = @qonection.query(query)
    return result.each.inject([]) { |s, r| s << r.to_s }
  end

  def prepare_query(q)
    (q =~ /SQL_NO_CACHE/) ? q : q.sub!("SELECT", "SELECT SQL_NO_CACHE")
  end

  def benchmark_time_in_miliseconds(q)
    Benchmark.realtime { @qonection.query(prepare_query(q)) } * 1000
  end

  def get_average_time_for_n_runs(n, q)
    runs = []
    n.times do 
      runs << benchmark_time_in_miliseconds(prepare_query(q))
    end
    average = runs.inject{ |sum, el| sum + el }.to_f / runs.size
  end
end

