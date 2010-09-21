require File.dirname(__FILE__) + '/../lib/report'
require 'spec_helper'

describe Report do
  context "creating and displaying" do
    before :all do
      @qinfo = get_connection
      before = ShowStatus.new(@qinfo)
      @qinfo.execute("SELECT * FROM accounts LIMIT 1000;")
      after = ShowStatus.new(@qinfo)
      @report = Report.new(before, after)
    end

    it "should set necessary fields" do
      @report.time.should > 0
      @report.query_cost.should > 0
      @report.rows_read_operations
      @report.rows_insert_operations
      @report.io_operations
      @report.query_cached?.should be_false
      @report.locks_immediate
      @report.locks_waited
    end


      



  end


end
