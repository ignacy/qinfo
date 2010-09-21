class ShowStatus

  def initialize(qinfo)
    results = qinfo.execute_straight("SHOW STATUS;")
    results.each do |row|
      self.class.send(:define_method, row["Variable_name"]) do
        row["Value"].to_i
      end
    end
  end

  def cost_of_IO_operations
    key_prefixed + created_prefixed
  end

  private
  
  def key_prefixed
    self.Key_blocks_not_flushed +
    self.Key_blocks_unused +
    self.Key_blocks_used +
    self.Key_read_requests +
    self.Key_reads +
    self.Key_write_requests +
    self.Key_writes
  end

  def created_prefixed
    self.Created_tmp_disk_tables + self.Created_tmp_files + self.Created_tmp_tables      
  end




end
