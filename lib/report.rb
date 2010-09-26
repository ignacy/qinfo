class Report
  attr_accessor :before, :now
  
  def initialize(before, now)
    @before, @now = before, now
  end

  def query_cost
    @now.last_query_cost
  end

  def rows_read_operations
    @before.cost_of_read_operations + @before.cost_of_InnoDB_reads +
      @now.cost_of_InnoDB_reads + @now.cost_of_read_operations
  end

  def rows_insert_operations

  end

  def io_operations
    @now.cost_of_IO_operations - @before.cost_of_IO_operations
  end

  def query_cached?
    (@now.qcache_queries_in_cache - @before.qcache_queries_in_cache ) > 0
  end

  def locks_immediate
    @now.table_locks_immediate - @before.table_locks_immediate 
  end

  def locks_waited
    @now.table_locks_waited - @before.table_locks_waited
  end
end
