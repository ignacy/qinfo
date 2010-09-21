require File.dirname(__FILE__) + '/../lib/qinfo'

require 'spec_helper'

describe Qinfo do
  context "perform a simple query" do

    before(:each) do
      @qinfo = get_connection
    end

    it "should add SQL_NO_CACHE directive if not present" do
      @qinfo.prepare_query("SELECT * FROM accounts LIMIT 10;").should =~ /SQL_NO_CACHE/
    end

    it "should perform a simple query" do
      @qinfo.execute("SELECT * FROM accounts LIMIT 10;").first.should match("john")
    end

    it "should perform benchark on times, the result should be close to 0" do
      benched = @qinfo.benchmark_time_in_miliseconds("SELECT * FROM accounts LIMIT 100;")
      benched.should be_close(0, 2)
    end

    it "get the average time, the result should be close to 0" do
      query = @qinfo.prepare_query("SELECT * FROM accounts LIMIT 100;")
      benched_10_times = @qinfo.get_average_time_for_n_runs(10, "SELECT * FROM accounts LIMIT 100;")
      benched_10_times.should be_close(0, 2)
    end

  end


  context "get data and prepare the raport" do
    before(:each) do
      @qinfo = get_connection
    end

    it "should run get show_status base info" do
      @qinfo.prepare_testing_enviroment
      @qinfo.before_status.should be_a ShowStatus
    end

    it "get the after status" do
      @qinfo.get_results
      @qinfo.after_status.should be_a ShowStatus
    end


  end
end
