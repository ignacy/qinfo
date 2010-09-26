require File.dirname(__FILE__) + '/../lib/qinfo/show_status'
require 'spec_helper'

describe ShowStatus do
  context "get server's status" do
    before(:each) do
      @qinfo = get_connection
      @qinfo.execute_straight("FLUSH STATUS");
      @qinfo.execute_straight("SELECT * FROM accounts LIMIT 10;")
      @show_status = ShowStatus.new(@qinfo)
    end

    it "should get the info for base profile" do
      @show_status.last_query_cost.should >= 0

      @show_status.innodb_rows_read.should >= 0
      @show_status.innodb_rows_inserted.should >= 0

      @show_status.cost_of_IO_operations.should >= 0
    end

    it "should recognize that query was cached" do
      @show_status.qcache_queries_in_cache.should >= 0
    end
  
    it "should be able to read table locks statistics" do
      @show_status.table_locks_immediate.should >= 0
      @show_status.table_locks_waited.should eql(0)
    end
  end
end
