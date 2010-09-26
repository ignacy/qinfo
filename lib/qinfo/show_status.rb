class ShowStatus

  def initialize(qinfo)
    results = qinfo.execute_straight("SHOW STATUS;")
    results.each do |row|
      self.class.send(:define_method, row["Variable_name"].downcase) do
        row["Value"].to_i
      end
    end
  end

  def cost_of_read_operations
    ["key", "next", "prev", "rnd", "rnd_next"].inject(0) do |sum, type|
      sum += self.send("handler_read_#{type}".to_sym)
    end
  end

  def cost_of_InnoDB_reads
    cost = ["ahead_rnd", "ahead_seq", "requests"].inject(0) do |sum, type|
      sum += self.send("innodb_buffer_pool_read_#{type}".to_sym)
    end
    return cost + self.innodb_buffer_pool_reads
  end

  def cost_of_IO_operations
    key_prefixed + created_prefixed
  end

  def cost_of_InnoDB_insert_operations
    self.innodb_rows_inserted + self.innodb_rows_updated 
  end

  private
  
  def key_prefixed
    self.key_blocks_not_flushed +
    self.key_blocks_unused +
    self.key_blocks_used +
    self.key_read_requests +
    self.key_reads +
    self.key_write_requests +
    self.key_writes
  end

  def created_prefixed
    self.created_tmp_disk_tables + self.created_tmp_files + self.created_tmp_tables      
  end
end
