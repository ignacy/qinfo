require File.dirname(__FILE__) + '/../lib/qinfo/report'
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
      #      @report.time.should > 0
    end

    it "should set query cost" do
      @report.query_cost.should > 0
    end

    it "should count row read operations" do
      @report.rows_read_operations.should be_a Integer
    end

    it "should count row insert operations" do
      @report.rows_insert_operations.should be_a Integer
    end

    it "should count io operations" do
      @report.io_operations.should be_a Integer
    end

    it "should not cache the query" do
      @report.query_cached?.should be_false
    end

    it "should get the locks values" do
      @report.locks_immediate.should be_a Integer
      @report.locks_waited.should be_a Integer
    end
  end
end
