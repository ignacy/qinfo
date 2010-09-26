module Formats
  class String
    def initialize(report)
      out = []

      out << "Qinfo report"
      out << "Query cost: #{report.query_cost}"
      out << "Row read operations: #{report.rows_read_operations}"
      out << "Row insert operations #{report.rows_insert_operations}"
      out << "IO operations: #{report.io_operations}"
      out << "Query went into cache? #{report.query_cached? ? "Yes" : "No"}"
      out << "Locks immediate: #{report.locks_immediate}"
      out << "Locks waited: #{report.locks_waited}"
       
      puts out.join("\n")
    end
  end
end
