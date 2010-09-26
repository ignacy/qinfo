require 'rubygems'
require 'builder'

module Formats
  class Html
    def initialize(report)
      b = Builder::XmlMarkup.new(:indent => 2)
      
      html = b.html {
        b.head {
          b.title "Qinfo report"
        }
        b.body {
          b.h1 "Query"
          b.table {
            b.tr {
              b.th "Query cost"
              b.td report.query_cost
            }
            b.tr {
              b.th "Row read operations"
              b.td report.rows_read_operations
            }
            b.tr {
              b.th "Row insert operations"
              b.td report.rows_insert_operations
            }
            b.tr {
              b.th "IO operations"
              b.td report.io_operations
            }
            b.tr {
              b.th "Query went into cache?"
              b.td report.query_cached? ? "Yes" : "No"
            }
            b.tr {
              b.th "Locks immediate"
              b.td report.locks_immediate
            }
            b.tr {
              b.th "Locks waited"
              b.td report.locks_waited
            }
          }
        }
      }
 
      puts html
    end
  end
end
