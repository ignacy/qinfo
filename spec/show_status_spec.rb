require File.dirname(__FILE__) + '/../lib/qinfo/show_status'
require 'spec_helper'

describe ShowStatus do
  context "get server's status" do
    before(:each) do
      @qinfo = get_connection
      @show_status = ShowStatus.new(@qinfo)
    end

    it "should get the info for base profile" do
      @show_status.Last_query_cost.should eql(0)

      @show_status.Innodb_rows_read.should >= 0
      @show_status.Innodb_rows_inserted.should >= 0

      @show_status.cost_of_IO_operations.should >= 0
      
      @show_status.Qcache_queries_in_cache.should >= 0
      
      @show_status.Table_locks_immediate.should >= 0
      @show_status.Table_locks_waited.should eql(0)
    end

  end
end
