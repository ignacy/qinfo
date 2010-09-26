qinfo
======

> Qinfo is a gem for profiling mysql queries.

  There are many methods to do query profiling, you can use mysql helpers (EXPLAIN, SHOW STATUS) or read the OS data (memory/cpu usage), and you can device some other tests. From my experience 90% of the times all you need are the tools built in the database. The difficult part is that each time you want to profile a query you have to login to the database, prepare the testing enviroment, run the query and then collect the results. This gem makes it easier for you. It does all the above steps in automated maner and it prepares custom format reports afterwards. 

Verison 1.0
======

This version is based on "SHOW STATUS" helper usage. It's the most verbose of the ways MySQL can inform you about your query - and as such it's also the best candidate for being parsed and formated in more readable way.

Instructions
======

To prepare and run the rests use:

    $> rake


To run examples use:

    $> ruby examples/simple_benchmark.rb    
    
